Given /^I have requested a driver from latitude "(.*?)" and longitude "(.*?)"$/ do |latitude, longitude|
  arguments = { user: @user,
                latitude: latitude,
                longitude: longitude,
                success: ->(r) { @driver_request = r },
                error: ->(e) { raise e } }

  ::Users::Requests::Create.(arguments)
end

Given /^a driver with taxi number "(.*?)" responds to my request with id "(.*?)"$/ do |taxi_number, driver_request_id|
  driver         = Driver.get_driver_by_number(taxi_number)
  driver_request = Driver::Request.find(driver_request_id)

  driver_request.assign_driver(driver)
end

Then /^the status from the driver "(.*?)" should be "(.*?)"$/ do |taxi_number, status|
  driver = Driver.get_driver_by_number(taxi_number)

  expect(driver.status).to eq status
end
