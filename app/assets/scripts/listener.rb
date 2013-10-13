require 'sinatra'
require 'openssl'
require 'base64'
require 'zip/zip'
require 'socket'
require 'pathname'

ip = Socket::getaddrinfo(Socket.gethostname,"echo",Socket::AF_INET)[0][3]
set :bind, ip

get '/' do
  return "<h1>hi there</h1>"
end

post '/upload' do
  signature = Base64.decode64(params[:signature])
  message = params[:filename]+params[:b64_file]+params[:timestamp]
  return unless validate(signature, message)
  return unless check_window(params[:timestamp])
  data = Base64.decode64(params[:b64_file])
  full_filename = params[:filename]+params[:timestamp].gsub(/[:\ ]/,"_")
  File.open(full_filename, "wb") {|f| f.write data }
  unzip(full_filename)
  return true
end

post '/up' do
  machine_id = find_machine(params[:machine_id])
  return unless machine_id
  fork do
    FileUtils.touch(Pathname.new("#{machine_id}").join("building"))
    sleep(10)
    FileUtils.rm_f(Pathname.new("#{machine_id}").join("building"))
  end
  return system("cd #{machine_id}; vagrant up")
end

post '/suspend' do
  machine_id = find_machine(params[:machine_id])
  return unless machine_id
  return system("cd #{machine_id}; vagrant suspend")
end

post '/halt' do
  machine_id = find_machine(params[:machine_id])
  return unless machine_id
  return system("cd #{machine_id}; vagrant halt")
end

post '/destroy' do
  machine_id = find_machine(params[:machine_id])
  return unless machine_id
  return system("cd #{machine_id}; vagrant destroy")
end

post '/reload' do
  machine_id = find_machine(params[:machine_id])
  return unless machine_id
  return system("cd #{machine_id}; vagrant reload --provision")
end

private
def validate(signature, message)
  key = OpenSSL::PKey::RSA.new File.read 'public_key.pem'
  digest = OpenSSL::Digest::SHA256.new
  return true if key.verify(digest, signature, message)
  puts "Signature check failed"
  status 500
  body "Signature Check Failed"
  return false
end

def check_window(timestamp)
  time = Time.parse(timestamp)
  return true if time.between?((Time.now - 300), (Time.now + 300))
  puts "Message expired"
  status 500
  body "Message expired"
  return false
end

def find_machine(id)
  signature = Base64.decode64(params[:signature])
  return false unless validate(signature, (params[:machine_id]+params[:timestamp]))
  return false unless check_window(params[:timestamp])
  machine = /[0-9]+/.match(id)[0].to_i
  return machine if !machine.nil?
  status 500
  body "Invalid machine id"
  return false
end

def unzip(file)
  Zip::ZipFile.open(file) do |zip|
    zip.each do |entry|
      next if entry.name =~ /__MACOSX/ or entry.name =~ /\.DS_Store/ or !entry.file?
      begin
       entry_path = File.join(entry.name)
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
       end # File.open
      end # begin
     end # zip.each
  end # ZipFile.open
  return true
end # def unzip
