Given /^the following drivers exist:$/ do |table|
  table.rows.each do |row|
    Driver.create_driver(*row)
  end
end

Given /^a user with phone number "(.*?)" exists$/ do |phone_number|
  @user = User.create!(phone_number: phone_number)
end

Given /^his coordinates are latitude "(.*?)" longitude "(.*?)"$/ do |latitude, longitude|
  @user.update(latitude: latitude,
               longitude: longitude)
end
