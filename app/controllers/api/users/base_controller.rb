module Api
  module Users
    class BaseController < ::Api::BaseController
      before_filter :find_and_authenticate_user!

      private

      def find_and_authenticate_user!
        user = User.find_by!(authentication_token: params[:authentication_token])
        sign_in :user, user, store: false
        authenticate_user!
      end
    end
  end
end
