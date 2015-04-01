module Api
  module Users
    class SessionsController < ::Api::Users::BaseController
      skip_before_filter :find_and_authenticate_user!, only: :create

      rescue_from User::AuthenticationError, ActiveRecord::RecordNotFound do |e|
        render json: { user: { error: e.message } },
          status: :unauthorized
      end

      def create
        @user = User.authenticate!(user_params)
        render :create, status: :created
      end

      def destroy
        User.destroy_authentication_token!(current_user)
        render json: { user: { message: "Successfully destroyed session" } },
          status: :ok
      end

      private

      def user_params
        params.fetch(:user, {}).permit(:email, :password)
      end
    end
  end
end
