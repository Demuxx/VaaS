json.array!(@puppet_options) do |puppet_option|
  json.extract! puppet_option, :name, :option, :puppet_id
  json.url puppet_option_url(puppet_option, format: :json)
end
