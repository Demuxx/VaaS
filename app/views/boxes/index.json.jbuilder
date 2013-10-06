json.array!(@boxes) do |box|
  json.extract! box, :name, :url
  json.url box_url(box, format: :json)
end
