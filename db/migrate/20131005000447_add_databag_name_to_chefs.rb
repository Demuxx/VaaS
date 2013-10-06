class AddDatabagNameToChefs < ActiveRecord::Migration
  def change
    add_column :chefs, :databag_name, :string
  end
end
