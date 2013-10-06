class PuppetMachine < ActiveRecord::Base
  belongs_to :puppet
  belongs_to :machine
end
