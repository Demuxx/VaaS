class Key < ActiveRecord::Base
  def self.generate(name, password)
    key = Key.new
    k = SSHKey.generate(:passphrase => password)
    key.name = name
    key.private = k.encrypted_private_key
    key.public = k.ssh_public_key
    key
  end
end
