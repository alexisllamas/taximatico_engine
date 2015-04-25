Given /^the following drivers exist:$/ do |table|
  table.rows.each do |row|
    Driver.create_driver(*row)
  end
end

Given /^his coordinates are latitude "(.*?)" longitude "(.*?)"$/ do |latitude, longitude|
  @user.update(latitude: latitude,
               longitude: longitude)
end
