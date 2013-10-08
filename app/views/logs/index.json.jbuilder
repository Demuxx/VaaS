json.array!(@logs) do |log|
  json.extract! log, :name, :path, :machine_id
  json.url log_url(log, format: :json)
end
