require 'rails_helper'

describe AuthenticationToken do
  let(:user) { create(:user) }

  describe ".get_valid_token" do
    subject { AuthenticationToken.get_valid_token(user) }

    context "when there is no token valid" do
      it "creates a new token" do
        expect { subject }.
          to change(user.authentication_tokens, :count).by 1
      end
    end

    context "when a token valid exists" do
      before { AuthenticationToken.get_valid_token(user) }

      it "gets the last valid token" do
        expect { subject }.
          to change(user.authentication_tokens, :count).by 0
      end
    end
  end
end
