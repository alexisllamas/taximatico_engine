Given /^A user with phone number "(.*?)" exists$/ do |phone_number|
  User.create!(phone_number: phone_number)
end
