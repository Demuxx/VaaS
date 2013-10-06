class AddDatabagPathToChefs < ActiveRecord::Migration
  def change
    add_column :chefs, :databag_path, :string
  end
end
