class CreatePuppetMachines < ActiveRecord::Migration
  def change
    create_table :puppet_machines do |t|
      t.references :puppet, index: true
      t.references :machine, index: true

      t.timestamps
    end
  end
end
