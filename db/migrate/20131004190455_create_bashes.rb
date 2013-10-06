class CreateBashes < ActiveRecord::Migration
  def change
    create_table :bashes do |t|
      t.string :file
      t.binary :raw

      t.timestamps
    end
  end
end
