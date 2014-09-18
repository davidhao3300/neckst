require 'httparty'
class EventbriteClient
  include HTTParty
  base_uri 'https://www.eventbriteapi.com/v3'

  # available API request methods are documented at:
  # http://developer.eventbrite.com/doc
  def method_request( method, params={} )
    #merge auth params into our request querystring
    params.merge!(token: ENV['EVENTBRITE_TOKEN'])
    method_header = method.to_s.split('_')
    resp = self.class.get("/#{method_header.first}/#{method_header.last}/", {:query => params})

    if resp['error']
      raise RuntimeError, resp['error']['error_message'], caller[1..-1]
    end
    return resp
  end

  def method_missing(method, *args, &block)
    self.method_request(method, args[0])
  end
end

