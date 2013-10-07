json.array!(@chef_jsons) do |chef_json|
  json.extract! chef_json, :chef_id, :key, :value
  json.url chef_json_url(chef_json, format: :json)
end
