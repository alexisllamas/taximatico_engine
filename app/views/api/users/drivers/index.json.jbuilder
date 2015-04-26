json.status "ok"
json.drivers do
  json.array! @drivers do |driver|
    json.id          driver.id
    json.name        driver.name
    json.taxi_number driver.taxi_number
    json.latitude    driver.latitude
    json.longitude   driver.longitude
  end
end
