FactoryGirl.define do
  factory :driver_request, class: "Driver::Request" do
    user nil
    latitude 1.5
    longitude 1.5
  end
end
