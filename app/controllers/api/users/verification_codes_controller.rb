module Api
  module Users
    class VerificationCodesController < ::Api::Users::BaseController
      skip_before_filter :find_and_authenticate_user!, only: :check

      def check
        ::Users::VerificationCodes::Check.(verification_code_params[:code],
                                           success: method(:check_success),
                                           error:   method(:check_error))
      end

      private

      def check_success(authentication_token)
        render json: { status: "ok", authentication_token: authentication_token },
          status: :ok
      end

      def check_error(error)
        render json: { status: "error", error: error },
          status: :unprocessable_entity
      end

      def verification_code_params
        params.require(:verification_code).permit(:code)
      end
    end
  end
end
