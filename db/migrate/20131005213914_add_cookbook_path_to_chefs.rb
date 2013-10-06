class AddCookbookPathToChefs < ActiveRecord::Migration
  def change
    add_column :chefs, :cookbook_path, :string
  end
end
