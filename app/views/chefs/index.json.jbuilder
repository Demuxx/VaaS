json.array!(@chefs) do |chef|
  json.extract! chef, :name, :tarbal, :databag
  json.url chef_url(chef, format: :json)
end
