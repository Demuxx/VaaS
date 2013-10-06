class CreateBashMachines < ActiveRecord::Migration
  def change
    create_table :bash_machines do |t|
      t.references :bash, index: true
      t.references :machine, index: true

      t.timestamps
    end
  end
end
