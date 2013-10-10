require 'sinatra'
require 'openssl'
require 'base64'
require 'zip/zip'

set :bind, '10.236.2.225'

get '/' do
  return "<h1>hi there</h1>"
end

post '/upload' do
  signature = Base64.decode64(params[:signature])
  b64_file = params[:b64_file]
  filename = params[:filename]
  timestamp = params[:timestamp]
  message = filename+b64_file+timestamp
  return unless validate(signature, message)
  return unless check_window(timestamp)
  data = Base64.decode64(b64_file)
  file = File.open((filename+timestamp), "wb") {|f| f.write data }
  out = unzip(filename+timestamp)
  return true
end

post '/command' do
  signature = Base64.decode64(params[:signature])
  message = params[:message]
  timestamp = params[:timestamp]
  return unless validate(signature, (message+timestamp))
  return unless check_window(timestamp)
  return system("#{message}")
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