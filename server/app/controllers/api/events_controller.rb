class Api::EventsController < ApplicationController
  def index
    render json: {
      events: [
        {
          name: "Neckst Grand Opening",
          description: "The best event ever. Wear formal.",
          start_time: DateTime.current + 1.day,
          end_time: DateTime.current + 1.day + 2.hours,
          type: :social,
          link: "http://neckst.herokuapp.com",
          location: {
            address: "1234 Neck St., Neckville, NY 10027"
          }
        },
        {
          name: "Crazy Fish Bankruptcy Celebration",
          description: "They got necked.",
          start_time: DateTime.current + 1.month,
          end_time: DateTime.current + 2.months,
          type: :social,
          link: "http://neckst.herokuapp.com",
          location: {
            latitude: 37.4283408,
            longitude: -122.1693066
          }
        }
      ]
    }
  end
end
