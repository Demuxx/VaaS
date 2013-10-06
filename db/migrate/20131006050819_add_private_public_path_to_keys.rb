class AddPrivatePublicPathToKeys < ActiveRecord::Migration
  def change
    add_column :keys, :private_path, :string
    add_column :keys, :public_path, :string
  end
end
