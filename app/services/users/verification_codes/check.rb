module Users
  module VerificationCodes
    class Check < BaseService
      attr_reader :code, :success, :error

      def initialize(code, success:, error: -> {})
        @code, @success, @error = code, success, error
      end

      def perform
        if verification_code.present? and verification_code.verify!
          success.call(authentication_token)
        else
          error.call("verification_code_not_exists")
        end
      end

      private

      def verification_code
        @verification_code ||= VerificationCode.find_by_code(code)
      end

      def authentication_token
        @authentication_token ||=
          AuthenticationToken.get_valid_token(verification_code.user)
      end
    end
  end
end
