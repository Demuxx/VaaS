require 'openssl'
require 'base64'
require 'rest_client'

def upload
  generate_keys if !File.exists?('private_key.pem')
  key = OpenSSL::PKey::RSA.new File.read 'private_key.pem'
  timestamp = Time.now.to_s
  filename = "app.zip"
  file = File.open(filename, 'rb')
  digest = OpenSSL::Digest::SHA256.new
  b64_file = Base64.encode64(file.read).gsub(/\n/, "")
  message = filename+b64_file+timestamp
  signature = Base64.encode64(key.sign(digest, message))
  ip = Socket::getaddrinfo(Socket.gethostname,"echo",Socket::AF_INET)[0][3]
  response = RestClient.post(
    "http://#{ip}:4567/upload", 
    {:b64_file => b64_file, :filename => filename, :signature => signature, :timestamp => timestamp}, 
    :multipart => true, :content_type => "multipart/form-data"
    )
  file.close
  puts response.body
end

def generate_keys
  key = OpenSSL::PKey::RSA.new 2048
  open 'private_key.pem', 'w' do |io|  io.write key.to_pem end
  open 'public_key.pem', 'w' do |io| io.write key.public_key.to_pem end
end

upload
