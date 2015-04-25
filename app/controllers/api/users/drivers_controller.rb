module Api
  module Users
    class DriversController < ::Api::Users::BaseController
      def index
        location = [params[:latitude].to_f, params[:longitude].to_f]
        @drivers = Driver.geosearch(*location)
      end
    end
  end
end
