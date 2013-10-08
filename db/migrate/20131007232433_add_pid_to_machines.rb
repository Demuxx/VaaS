class AddPidToMachines < ActiveRecord::Migration
  def change
    add_column :machines, :pid, :integer
  end
end
