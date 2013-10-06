json.array!(@puppet_machines) do |puppet_machine|
  json.extract! puppet_machine, :puppet_id, :machine_id
  json.url puppet_machine_url(puppet_machine, format: :json)
end
