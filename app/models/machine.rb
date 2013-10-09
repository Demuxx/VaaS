class Machine < ActiveRecord::Base
  after_create dirs("create")
  before_destroy dirs("destroy")
  
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
  has_many :logs, dependent: :destroy

  def self.poll_status
    while true
      for machine in Machine.all
        begin
          machine.status = machine.get_metadata
          puts machine.status.name
          machine.port = machine.get_port if ["Up", "Down"].include?(machine.status.name)
          machine.save
        rescue
        end
        sleep(1)
      end
    end
  end
  
  def dirs(method)
    case method
    when "create"
      root = Rails.root
      FileUtils.mkdir_p(root.join("vms", @machine.id.to_s, "logs"))
      FileUtils.mkdir_p(root.join("uploads", @machine.id.to_s, "bashes"))
      FileUtils.mkdir_p(root.join("uploads", @machine.id.to_s, "chefs"))
      FileUtils.mkdir_p(root.join("uploads", @machine.id.to_s, "puppets"))
    end
    
  end
  
  def vagrant_path
    Rails.root.join("vms", @machine.id.to_s, "Vagrantfile").to_s
  end
  
  def logs_path
    Rails.root.join("vms", "#{@machine.id}", "logs")
  end

  def vagrant_init
    path = Rails.root.join("vms", "#{self.id}")
    FileUtils.mkdir_p(path)
    pid = spawn("cd #{path}; vagrant init #{self.box.name} #{self.box.url}", [:out, :err]=>[self.log, "w"])
    Process.detach(pid)
    #raise "Init command failed!" if !command
  end

  def generate_vagrant
    pin_vagrant_key_file(self)
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
    create_vagrant_file(self)
    self.pid = spawn("cd #{path}; vagrant up --no-provision", [:out, :err]=>[self.log, "w"])
    Process.detach(self.pid)
    self.status = Status.where(name: "Pending Action").first
    self.save
  end

  def suspend
    path = Rails.root.join("vms", "#{self.id}")
    self.pid = spawn("cd #{path}; vagrant suspend", [:out, :err]=>[self.log, "w"])
    Process.detach(self.pid)
    self.save
  end

  def provision
    
  end

  def up_provision
    path = Rails.root.join("vms", "#{self.id}")
    self.pid = spawn("cd #{path}; vagrant up --provision", [:out, :err]=>[self.log, "w"])
    Process.detach(self.pid)
    self.save
  end
  
  def get_port
    path = Rails.root.join("vms", "#{self.id}")
    output = `cd #{path}; vagrant ssh-config`
    return /(Port\ )(.*)/.match(output.split("\n")[3])[2] if !output.nil? and !output.empty?
  end
  
  def get_metadata
    path = Rails.root.join("vms", "#{self.id}")
    output = `cd #{path}; vagrant status`
    status_string = /([a-z]+[\ ]+)([^\(]+)([\(])/.match(output.split("\n")[2])[2].strip!
    return Status.where(name: "Pending Process") if !self.pid.nil? and pid_running?(self.pid)
    case status_string
    when "running"
      return Status.where(name: "Up").first
    when "saved"
      return Status.where(name: "Down").first
    when "not created"
      return Status.where(name: "Not Created").first
    when "poweroff"
      return Status.where(name: "Off").first
    when "restarting"
      return Status.where(name: "Restarting").first
    else
      return Status.where(name: "Unknown").first
    end
  end

  private
  def command(machine, cmd, log)
    path = Rails.root.join("vms", "#{machineid}")
    self.pid = spawn("cd #{path}; vagrant provision", [:out, :err]=>[log, "w"])
    Process.detach(self.pid)
    self.save
  end
  
  def pid_running?(pid)
    begin
      Process.kill(0, pid)
      return true
    rescue Errno::EPERM
      raise "No permissions to query the process."
    rescue Errno::ESRCH
      return false
    rescue
      raise "Unable to check process status"
    end
  end
  
  def pin_vagrant_key_file(machine)
    template = File.open(Rails.root.join('app', 'assets', 'vagrant_templates', 'vagrant_key_pinning.erb'))
    erb = ERB.new(template.read)
    vm_path = Rails.root.join("vms", "#{machine.id}", "Vagrantfile")
    key = File.open(Rails.root.join("server_keys", "public"), "r").read
    box = machine.box.name
    box_url = machine.box.url
    File.open(vm_path, 'w') do |f|
      f.write erb.result( binding )
    end
    FileUtils.mkdir_p(Rails.root.join("vms", machine.id.to_s, "logs").to_s)
    pin_pid = spawn("cd #{vm_path}; vagrant up", [:out, :err]=>[machine.log, "w"])
    Process.detach(pin_pid)
  end
  
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
