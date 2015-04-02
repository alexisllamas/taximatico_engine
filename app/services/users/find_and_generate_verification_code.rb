module Users
  class FindAndGenerateVerificationCode
    def self.call(*args)
      new(*args).perform
    end

    attr_reader :phone_number, :success, :error, :user

    def initialize(phone_number, success:, error: ->(u){})
      @phone_number, @success, @error = phone_number, success, error
      @user = User.find_or_initialize_by(phone_number: phone_number)
    end

    def perform
      if user.save
        generate_and_send_verification_code
        success.call(user)
      else
        error.call(user)
      end
    end

    def generate_and_send_verification_code
      verification_code = VerificationCode.generate_verification_code(user)
      Users::SendVerificationCode.to(user, verification_code)
    end
  end
end
