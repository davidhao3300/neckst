class PublicController < ApplicationController
  def home
    render json: {
      message: "Neckst",
      success: true
    }
  end
end
