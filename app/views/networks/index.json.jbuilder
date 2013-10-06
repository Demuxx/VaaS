json.array!(@networks) do |network|
  json.extract! network, :name, :bridge
  json.url network_url(network, format: :json)
end
