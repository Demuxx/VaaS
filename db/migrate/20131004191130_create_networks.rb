class CreateNetworks < ActiveRecord::Migration
  def change
    create_table :networks do |t|
      t.string :name
      t.string :bridge

      t.timestamps
    end
  end
end
