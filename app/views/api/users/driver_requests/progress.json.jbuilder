json.status "ok"
json.progress do
  json.array! @driver_locations do |driver_location|
    json.id driver_location.id
    json.location do
      json.latitude  driver_location.latitude
      json.longitude driver_location.longitude
    end
    json.created_at driver_location.created_at
  end
end
