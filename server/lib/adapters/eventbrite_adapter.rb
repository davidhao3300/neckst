module Adapters
  class EventbriteAdapter
    # Grabs events given a set of coordinates.
    def self.events_for_coordinates(latitude, longitude, distance = '30mi', filters={})
      client = EventbriteClient.new

      # Ask Eventbrite for events
      json = client.events_search(
        {
          'location.latitude' => latitude,
          'location.longitude' => longitude,
          'location.within' => distance
        }
      ).with_indifferent_access[:events]

      # Parse events
      json.map! do |event|
        parsed = {
          name: event[:name][:text],
          description: event[:description][:text],
          picture: event[:logo_url],
          start_time: DateTime.parse(event[:start][:utc]),
          end_time: DateTime.parse(event[:end][:utc]),
          type: event[:category].present? ? event[:category][:name] : :eventbrite,
          link: event[:url]
        }

        venue = event[:venue]

        if venue.present?
          if venue[:latitude].to_f == 0 && venue[:longitude].to_f == 0
            parsed[:location] = { address: venue[:address] }
          else
            parsed[:location] = {
              latitude: venue[:latitude].to_f,
              longitude: venue[:longitude].to_f
            }
          end
        else
          parsed[:location] = nil
        end

        parsed
      end

      json
    end
  end
end
