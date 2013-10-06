class AddPortToMachine < ActiveRecord::Migration
  def change
    add_column :machines, :port, :integer
  end
end
