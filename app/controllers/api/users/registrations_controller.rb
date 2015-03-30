module Api
  module Users
    class RegistrationsController < ::Api::Users::BaseController
      skip_before_filter :find_and_authenticate_user!, only: :create

      rescue_from ActiveRecord::RecordInvalid do |e|
        render json: { user: { errors: e.message } },
          status: :unprocessable_entity
      end

      def create
        @user = User.register!(user_params)
        render :create, status: :created
      end

      private

      def user_params
        params.fetch(:user, {}).permit(:name,
                                       :email,
                                       :username,
                                       :phone_number,
                                       :profile_picture,
                                       :password,
                                       :password_confirmation)
      end
    end
  end
end
