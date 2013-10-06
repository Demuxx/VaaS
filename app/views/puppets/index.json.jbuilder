json.array!(@puppets) do |puppet|
  json.extract! puppet, :name, :manifest_path, :modules_path, :manifest_file
  json.url puppet_url(puppet, format: :json)
end
