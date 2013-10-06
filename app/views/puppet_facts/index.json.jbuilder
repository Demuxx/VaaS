json.array!(@puppet_facts) do |puppet_fact|
  json.extract! puppet_fact, :name, :key, :value, :puppet_id
  json.url puppet_fact_url(puppet_fact, format: :json)
end
