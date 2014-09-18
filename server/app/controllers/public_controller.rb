class PublicController < ApplicationController
  def home
    render json: {
      message: "Neckst"
    }
  end
end
