class CreateChefJsons < ActiveRecord::Migration
  def change
    create_table :chef_jsons do |t|
      t.references :chef, index: true
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
