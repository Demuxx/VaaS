class AddCookbookNameToChef < ActiveRecord::Migration
  def change
    add_column :chefs, :cookbook_name, :string
  end
end
