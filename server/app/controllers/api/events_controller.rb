class Api::EventsController < ApplicationController
  before_filter :check_params

  def index
    render json: { events: Adapters::EventbriteAdapter.events_for_coordinates(params[:latitude], params[:longitude], params[:distance]) }
  end

  private
  def check_params
    # Numerical params check
    [:latitude, :longitude].each do |param|
      if params[param].nil?
        raise BadRequestError, "Missing parameter: #{param}"
      end

      # Check if param is numeric
      # TODO: Make this a library method
      if params[param].to_f.to_s != params[param] && params[param].to_i.to_s != params[param]
        raise BadRequestError, "Parameter #{param} is not a number"
      end
    end

    # Distance param check
    # TODO: Make this accept decimal distances as well
    unless params[:distance].nil? || /\d+mi$/ =~ params[:distance] || /\d+km$/ =~ params[:distance]
      raise BadRequestError, "Parameter distance has improper formatting"
    end
  end
end
