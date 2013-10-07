class AddLogToMachines < ActiveRecord::Migration
  def change
    add_column :machines, :log, :text
  end
end
