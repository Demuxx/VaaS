class Machine < ActiveRecord::Base
  belongs_to :box
  belongs_to :network
  belongs_to :key
  belongs_to :status
  has_many :chef_machines
  has_many :chefs, through: :chef_machines
  has_many :puppet_machines
  has_many :puppets, through: :puppet_machines
  has_many :bash_machines
  has_many :bashes, through: :bash_machines

  def get_status
    path = Rails.root.join("vms", "#{self.id}")
    output = `cd #{path}; vagrant status`
    status_string = /([a-z]+[\ ]+)([^\(]+)([\(])/.match(output.split("\n")[2])[2].strip!
    case status_string
    when "running"
      puts "running"
      return Status.where(name: "Up").first
    when "saved"
      puts "saved"
      return Status.where(name: "Down").first
    when "not created"
      puts "not created"
      return Status.where(name: "Not Created").first
    when "poweroff"
      puts "poweroff"
      return Status.where(name: "Off").first
    when "restarting"
      puts "restarting"
      return Status.where(name: "Restarting").first
    else
      puts "unknown"
      return Status.where(name: "Unknown").first
    end
  end

  def get_port
    path = Rails.root.join("vms", "#{self.id}")
    output = `cd #{path}; vagrant ssh-config`
    return /(Port\ )(.*)/.match(output.split("\n")[3])[2] if !output.empty?
  end

  def vagrant_init
    path = Rails.root.join("vms", "#{self.id}")
    FileUtils.remove_dir(path) if File.directory?(path)
    FileUtils.mkdir_p(path)
    command = `cd #{path}; vagrant init #{self.box.name} #{self.box.url}`
    raise "Init command failed!" if !command
  end

  def generate_vagrant
    create_vagrant_file(self)
    dst = Rails.root.join("vms", "#{self.id}")
    
    for bash in self.bashes
      copy_and_unzip(bash.file_path, dst.join("bashes"))
    end
    
    for chef in self.chefs
      copy_and_unzip(chef.cookbook_path, dst.join("cookbooks"))
      copy_and_unzip(chef.databag_path, dst.join("data_bags")) if !chef.databag_path.nil?
    end
    
    for puppet in self.puppets
      copy_and_unzip(puppet.manifest_path, dst.join("manifests"))
    end
  end
  
  def up
    path = Rails.root.join("vms", "#{self.id}")
    output = spawn("cd #{path}; vagrant up")
  end
  
  def suspend
    path = Rails.root.join("vms", "#{self.id}")
    output = spawn("cd #{path}; vagrant suspend")
  end
      
  private
  def create_vagrant_file(machine)
    template = File.open(Rails.root.join('app', 'assets', 'vagrant_templates', 'vagrantfile.erb'))
    erb = ERB.new(template.read)
    box = machine.box.name
    box_url = machine.box.url
    network = machine.network.name
    bridge = machine.network.bridge
    key = machine.key.public
    chefs = machine.chefs
    bashes = machine.bashes
    puppets = machine.puppets
    File.open(Rails.root.join("vms", "#{machine.id}", "Vagrantfile"), 'w') do |f|
      f.write erb.result( binding )
    end
  end
  
  def copy_and_unzip(src, dst)
    FileUtils.mkdir_p(dst)
    if !/\.zip$/.match(src).nil?
      Zip::ZipFile.open(src) do |zip|
       zip.each do |entry|
        next if entry.name =~ /__MACOSX/ or entry.name =~ /\.DS_Store/ or !entry.file?

        begin
         entry_path = File.join(dst, entry.name)
         FileUtils.mkdir_p(File.dirname(entry_path))
         zip.extract(entry, entry_path) unless File.exist?(entry_path)
        rescue Errno::ENOENT
         # when the entry can not be found
         data = entry.get_input_stream.read
         file = StringIO.new(@data)
         file.class.class_eval { attr_accessor :original_filename, :content_type }
         file.original_filename = entry.name
         file.content_type = MIME::Types.type_for(entry.name)

         file_path = File.join(dst, file.original_filename)
         FileUtils.mkdir_p(File.dirname(file_path))
         File.open(file_path, 'w') do |f|
           f.write data
         end
        end
       end
      end
    else
      FileUtils.cp_r(src, dst)
    end
  end
end
