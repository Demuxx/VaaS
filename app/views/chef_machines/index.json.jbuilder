json.array!(@chef_machines) do |chef_machine|
  json.extract! chef_machine, :chef_id, :machine_id
  json.url chef_machine_url(chef_machine, format: :json)
end
