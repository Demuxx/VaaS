class AddFilePathToBashes < ActiveRecord::Migration
  def change
    add_column :bashes, :file_path, :string
  end
end
