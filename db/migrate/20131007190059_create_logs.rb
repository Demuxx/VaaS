class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :name
      t.string :path
      t.references :machine, index: true

      t.timestamps
    end
  end
end
