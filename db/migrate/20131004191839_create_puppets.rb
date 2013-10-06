class CreatePuppets < ActiveRecord::Migration
  def change
    create_table :puppets do |t|
      t.string :name
      t.binary :manifest_file

      t.timestamps
    end
  end
end
