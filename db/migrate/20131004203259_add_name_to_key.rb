class AddNameToKey < ActiveRecord::Migration
  def change
    add_column :keys, :name, :string
  end
end
