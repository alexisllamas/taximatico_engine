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

  describe ".find_by_code" do
    let(:verification_code) { VerificationCode.generate_verification_code(user) }

    subject { VerificationCode.find_by_code(verification_code.code) }

    context "when the code has not been verified" do
      it "returns the verification code object" do
        expect(subject).to eq(verification_code)
      end
    end

    context "when the verification code has been verified" do
      before { verification_code.verify! }

      it "returns nil" do
        expect(subject).to be_nil
      end
    end
  end

  describe "#verify!" do
    let(:verification_code) { VerificationCode.generate_verification_code(user) }

    subject { verification_code.verify! }

    it "updates the verification code to be verified" do
      subject
      expect(verification_code).to be_verified
    end
  end
end
