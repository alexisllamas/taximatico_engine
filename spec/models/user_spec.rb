require 'rails_helper'

describe User do
  describe "#register" do
    let(:user_params) { { email:                 Faker::Internet.email,
                          name:                  Faker::Name.name,
                          username:              Faker::Internet.user_name,
                          profile_picture:       File.open("#{Rails.root}/spec/support/fixtures/profile_picture.jpg"),
                          password:              'supersecret',
                          password_confirmation: 'supersecret' } }

    subject { User.register(user_params) }

    it "creates the user and assigns an authentication token" do
      expect { subject }.
        to change(User, :count).by 1
    end

    it "creates the user and assigns an authentication token" do
      user = subject
      expect(user.authentication_token).to be_present
    end
  end
end
