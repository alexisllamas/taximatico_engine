module Api
  module Users
    class BaseController < ::Api::BaseController
      prepend_before_filter :find_and_authenticate_user!
      before_filter :authenticate_user!

      private

      def find_and_authenticate_user!
        if user
          sign_in :user, user, store: false
        end
      end

      def user
        @user ||= User.find_by_authentication_token(params[:authentication_token])
      end
    end
  end
end
