Given /^a user with email "(.*?)" and password "(.*?)" exists$/ do |email, password|
  @user = User.register!(email: email,
                         password: password,
                         password_confirmation: password,
                         phone_number: Faker::PhoneNumber.phone_number)
end

Given /^its authentication token is "(.*?)"$/ do |authentication_token|
  @user.update(authentication_token: authentication_token)
end
