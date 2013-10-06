json.array!(@statuses) do |status|
  json.extract! status, :name, :color
  json.url status_url(status, format: :json)
end
