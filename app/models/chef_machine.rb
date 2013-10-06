class ChefMachine < ActiveRecord::Base
  belongs_to :chef
  belongs_to :machine
end
