json.array!(@keys) do |key|
  json.extract! key, :private, :public
  json.url key_url(key, format: :json)
end
