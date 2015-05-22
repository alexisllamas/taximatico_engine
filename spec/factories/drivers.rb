FactoryGirl.define do
  factory :driver do
    name        { Faker::Name.name }
    taxi_number { rand(0..100) }
  end
end
