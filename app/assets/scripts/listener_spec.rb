require 'openssl'
require 'base64'
require 'rest_client'

def upload
  key = OpenSSL::PKey::RSA.new File.read 'private_key.pem'
  timestamp = Time.now.to_s
  filename = "app.zip"
  file = File.open(filename, 'rb')
  digest = OpenSSL::Digest::SHA256.new
  b64_file = Base64.encode64(file.read).gsub(/\n/, "")
  message = filename+b64_file+timestamp
  signature = Base64.encode64(key.sign(digest, message))
  response = RestClient.post(
    'http://10.236.2.225:4567/upload', 
    {:b64_file => b64_file, :filename => filename, :signature => signature, :timestamp => timestamp}, 
    :multipart => true, :content_type => "multipart/form-data"
    )
  file.close
  puts response.body
end

upload