class CreatePuppetOptions < ActiveRecord::Migration
  def change
    create_table :puppet_options do |t|
      t.string :name
      t.text :option
      t.references :puppet, index: true

      t.timestamps
    end
  end
end
