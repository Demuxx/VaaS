require 'pathname'

def status
  while true
    vms = Dir.entries('.').select do |entry| 
      File.directory? File.join('.',entry) and !(entry =='.' || entry == '..') and 
        !(/[^0-9]/.match(entry))
    end # vms
    
    for vm in vms
      begin
        # Status
        File.open(Pathname.new("#{vm}").join("status"), 'w') do |f| 
          output = `cd #{vm}; vagrant status`
          f.write /([a-z]+[\ ]+)([^\(]+)([\(])/.match(output.split("\n")[2])[2].strip!
          puts /([a-z]+[\ ]+)([^\(]+)([\(])/.match(output.split("\n")[2])[2].strip!
        end # File.open
        
        # Port
        File.open(Pathname.new("#{vm}").join("port")) do |f|
          output = `cd #{vm}; vagrant ssh-config`
          f.write /(Port\ )(.*)/.match(output.split("\n")[3])[2] if !output.nil? and !output.empty?
          puts /(Port\ )(.*)/.match(output.split("\n")[3])[2] if !output.nil? and !output.empty?
        end # File.open
      rescue
      end # begin
      sleep(1)
    end # for vm
  end # while true
end # def

status