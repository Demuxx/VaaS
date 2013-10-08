class AddVagrantPathToMachines < ActiveRecord::Migration
  def change
    add_column :machines, :vagrant_path, :string
  end
end
