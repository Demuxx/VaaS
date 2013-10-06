json.array!(@machines) do |machine|
  json.extract! machine, :name, :description, :box_id, :network_id, :key_id, :status_id
  json.url machine_url(machine, format: :json)
end
