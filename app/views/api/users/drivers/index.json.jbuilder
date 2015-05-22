json.status "ok"
json.drivers do
  json.array! @drivers do |driver|
    json.id          driver.id
    json.name        driver.name
    json.taxi_number driver.taxi_number
    json.location do
      json.latitude    driver.location[:lat]
      json.longitude   driver.location[:lon]
    end
  end
end
