require 'rails_helper'

describe Users::VerificationCodes::Check do
  let(:user) { create(:user) }
  let(:verification_code) { VerificationCode.generate_verification_code(user) }
  let(:success) { double :success, call: true }
  let(:error) { double :error, call: true }
  let(:args) { [verification_code.code, { success: success, error: error }] }
  let(:token) { AuthenticationToken.get_valid_token(user) }

  subject { Users::VerificationCodes::Check.(*args) }

  describe ".call" do
    context "with a valid code" do
      it "calls the success method and passes the authentication token" do
        expect(success).to receive(:call).
          with(token)
        subject
      end

      it "changes the verification code to verified" do
        expect { subject }.
          to change { verification_code.reload; verification_code.verified }.
          to true
      end
    end

    context "with an invalid code" do
      let(:verification_code) { double code: "not_a_valid_code" }

      it "calls the error method and passes the error message" do
        expect(error).to receive(:call).
          with("verification_code_not_exists")
        subject
      end
    end
  end
end
