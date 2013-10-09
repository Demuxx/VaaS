class Key < ActiveRecord::Base
  def self.generate(name, password)
    key = Key.new
    k = SSHKey.generate(:passphrase => password)
    key.name = name
    key.private = k.encrypted_private_key
    key.public = k.ssh_public_key
    key
  end
  
  def self.generate_server_key
    k = SSHKey.generate
    FileUtils.mkdir_p(Rails.root.join("server_keys"))
    File.open(Rails.root.join("server_keys", "private"), "w") { |f| f.write k.private_key }
    File.open(Rails.root.join("server_keys", "public"), "w") { |f| f.write k.ssh_public_key }
  end
end
