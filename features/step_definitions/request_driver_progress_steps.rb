Given /^the driver "(.*?)" is now at latitude "(.*?)" and "(.*?)"$/ do |taxi_number, latitude, longitude|
  driver = Driver.get_driver_by_number(taxi_number)

  driver.update_location(latitude, longitude)
  driver.current_location.assign_driver_request(@driver_request)
end
