Given /^the following drivers exist:$/ do |table|
  Driver.__elasticsearch__.create_index! force: true
  table.rows.each do |row|
    Driver.create_driver(*row)
  end
  Driver.__elasticsearch__.refresh_index!
end

Given /^his coordinates are latitude "(.*?)" longitude "(.*?)"$/ do |latitude, longitude|
  @user.update(latitude: latitude,
               longitude: longitude)
end

Given /^I set the request with the header "(.*?)" as "(.*?)"$/ do |request_header, authentication_token|
  header request_header, authentication_token
end

Given /^the time is (\d+)\-(\d+)\-(\d+) (\d+):(\d+)$/ do |year, month, day, hour, minute|
  Timecop.freeze DateTime.new(year.to_i, month.to_i, day.to_i, hour.to_i, minute.to_i)
end
