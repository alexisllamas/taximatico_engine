require 'rails_helper'

describe User do
  describe "#register!" do
    let(:user_params) { attributes_for :user }

    subject { User.register!(user_params) }

    it "creates the user and assigns an authentication token" do
      expect { subject }.
        to change(User, :count).by 1
    end

    it "creates the user and assigns an authentication token" do
      user = subject
      expect(user.authentication_token).to be_present
    end
  end

  describe "#authenticate!" do
    let(:user) { create :user }
    let(:user_params) { { email: user.email, password: "supersecret" } }

    subject { User.authenticate!(user_params) }

    context "with valid password" do
      it "authenticates the user" do
        u = subject
        expect(u).to eq user
      end
    end

    context "with invalid password" do
      let(:user_params) { { email: user.email, password: "not_the_password" } }
      it "authenticates the user" do
        expect { subject }.
          to raise_error(User::AuthenticationError, "Invalid password")
      end
    end

    context "with invalid email" do
      let(:user_params) { { email: Faker::Internet.email, password: "supersecret" } }
      it "authenticates the user" do
        expect { subject }.
          to raise_error(ActiveRecord::RecordNotFound, "Couldn't find User")
      end
    end
  end

  describe "#destroy_authentication_token!" do
    let(:user) { create :user }

    subject { User.destroy_authentication_token!(user) }

    it "destroys and replaces the old token for a new one" do
      expect { subject }.
        to change { user.reload ; user.authentication_token }
    end
  end
end
