require 'rails_helper'

describe VerificationCode do
  let(:user) { create(:user) }

  subject { VerificationCode.generate_verification_code(user) }

  describe "#generate_verification_code" do
    context "when no verification code exists" do
      it "generates the verification code when no code is present" do
        expect { subject }.
          to change(user.verification_codes, :count).by 1
      end

      it "creates the code" do
        verification_code = subject
        expect(verification_code).to_not be_nil
      end
    end

    context "when a verification code exists" do
      before { VerificationCode.generate_verification_code(user) }

      it "generates the verification code when no code is present" do
        expect { subject }.
          to change(user.verification_codes, :count).by 0
      end
    end
  end
end
