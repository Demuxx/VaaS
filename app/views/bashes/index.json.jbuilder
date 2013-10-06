json.array!(@bashes) do |bash|
  json.extract! bash, :raw, :file
  json.url bash_url(bash, format: :json)
end
