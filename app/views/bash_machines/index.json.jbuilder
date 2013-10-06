json.array!(@bash_machines) do |bash_machine|
  json.extract! bash_machine, :bash_id, :machine_id
  json.url bash_machine_url(bash_machine, format: :json)
end
