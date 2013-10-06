class CreateMachines < ActiveRecord::Migration
  def change
    create_table :machines do |t|
      t.string :name
      t.text :description
      t.references :box, index: true
      t.references :network, index: true
      t.references :key, index: true
      t.references :status, index: true

      t.timestamps
    end
  end
end
