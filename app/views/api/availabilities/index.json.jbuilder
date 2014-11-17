json.availabilities do
  json.array!(@items) do |item|
    json.rates do
      json.extract! item, :rate_id
    end
  end
end
