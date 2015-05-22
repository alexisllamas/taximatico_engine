Given /^the driver "(.*?)" is now at latitude "(.*?)" and "(.*?)"$/ do |taxi_number, latitude, longitude|
  driver = Driver.where(taxi_number: taxi_number).first

  driver.update_location(latitude, longitude)
  driver.current_location.assign_driver_request(@driver_request)
end
