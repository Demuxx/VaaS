class BashMachine < ActiveRecord::Base
  belongs_to :bash
  belongs_to :machine
end
