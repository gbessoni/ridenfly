json.array!(@airports) do |airport|
  json.extract! airport, :id, :name, :street_address, :city, :state, :zipcode, :code
  json.url admin_airport_url(airport, format: :json)
end
