module Api
  module Users
    class RegistrationsController < ::Api::Users::BaseController
      skip_before_filter :find_and_authenticate_user!, only: :create

      def create
        ::Users::FindAndGenerateVerificationCode.(user_params[:phone_number], success: ->(user) {
          render json: {
            status: "ok",
            message: "verification_code_sent"
          }, status: :created
        }, error: ->(user) {
          render json: {
            status: "error",
            errors: user.errors.full_messages
          }, status: :unprocessable_entity
        })
      end

      private

      def user_params
        params.fetch(:user, {}).permit(:phone_number)
      end
    end
  end
end
