class CreateChefMachines < ActiveRecord::Migration
  def change
    create_table :chef_machines do |t|
      t.references :chef, index: true
      t.references :machine, index: true

      t.timestamps
    end
  end
end
