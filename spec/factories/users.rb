FactoryGirl.define do
  factory :user do
    email                 { Faker::Internet.email }
    name                  { Faker::Name.name }
    username              { Faker::Internet.user_name }
    phone_number          { "+3121125642" }
    profile_picture       { File.open("#{Rails.root}/spec/support/fixtures/profile_picture.jpg") }
    password              { 'supersecret' }
    password_confirmation { 'supersecret' }
  end
end
