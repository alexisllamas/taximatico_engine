module Api
  module Users
    class RegistrationsController < ::Api::Users::BaseController
      skip_before_filter :authenticate_user!, only: :create

      def create
        ::Users::VerificationCodes::Create.(user_params[:phone_number],
                                            success: method(:create_success),
                                            error: method(:create_error))
      end

      private

      def create_success(user)
        render json: { status: "ok", message: "verification_code_sent" },
          status: :created
      end

      def create_error(user)
        render json: { status: "error", errors: user.errors.full_messages },
          status: :unprocessable_entity
      end

      def user_params
        params.fetch(:user, {}).permit(:phone_number)
      end
    end
  end
end
