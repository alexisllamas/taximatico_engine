class HomeController < ApplicationController
  def index
    render json: { message: "Taximatico API server, go to http://www.taximatico.mx to se our website" },
      status: :ok
  end
end
