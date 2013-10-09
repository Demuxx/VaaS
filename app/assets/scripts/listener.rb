require 'sinatra'
require 'openssl'
require 'base64'

set :bind, '192.168.1.151'

get '/' do
  return "<h1>hi there</h1>"
end

post '/upload' do
  signature = Base64.decode64(params[:signature])
  file = params[:file]
  path = params[:path]
  timestamp = params[:timestamp]
  return unless validate(signature, (path+file), timestamp)
  return unless check_window(timestamp)
end

post '/command' do
  signature = Base64.decode64(params[:signature])
  message = params[:message]
  timestamp = params[:timestamp]
  return unless validate(signature, message, timestamp)
  return unless check_window(timestamp)
  return system("#{message}")
end

private
def validate(signature, message, timestamp)
  key = OpenSSL::PKey::RSA.new File.read 'public_key.pem'
  digest = OpenSSL::Digest::SHA256.new
  return true if key.verify(digest, signature, (message+timestamp))
  status 500
  body "Signature Check Failed"
  return false
end

def check_window(timestamp)
  time = Time.parse(timestamp)
  return true if time.between?((Time.now - 300), (Time.now + 300))
  status 500
  body "Message expired"
  return false
end