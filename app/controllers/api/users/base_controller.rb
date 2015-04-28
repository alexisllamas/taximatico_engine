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
        @user ||= User.find_by_authentication_token(authentication_token)
      end

      def authentication_token
        request.headers['X-AUTHENTICATION-TOKEN']
      end
    end
  end
end
