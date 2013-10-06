class AddNameToBash < ActiveRecord::Migration
  def change
    add_column :bashes, :name, :string
  end
end
