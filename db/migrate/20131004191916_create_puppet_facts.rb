class CreatePuppetFacts < ActiveRecord::Migration
  def change
    create_table :puppet_facts do |t|
      t.string :name
      t.string :key
      t.text :value
      t.references :puppet, index: true

      t.timestamps
    end
  end
end
