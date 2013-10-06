class AddManifestFileNameToPuppets < ActiveRecord::Migration
  def change
    add_column :puppets, :manifest_filename, :string
  end
end
