Given /^a user with phone number "(.*?)" exists$/ do |phone_number|
  @user = User.create!(phone_number: phone_number)
end
