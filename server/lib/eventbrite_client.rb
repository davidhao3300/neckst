require 'httparty'
class EventbriteClient
  include HTTParty
  base_uri 'https://www.eventbriteapi.com'

  def initialize( auth_tokens )
    @auth = {}
    @data_type = (auth_tokens.is_a?(Hash) and auth_tokens.include? :data_type) ? auth_tokens[:data_type] : 'json'
    if auth_tokens.is_a? Hash
      if auth_tokens.include? :access_token
        # use oauth2 authentication tokens
        self.class.headers 'Authorization' => "Bearer #{auth_tokens[:access_token]}"
      elsif auth_tokens.include? :app_key
        #use api_key OR api_key + user_key OR api_key+email+pass
        if auth_tokens.include? :user_key
          # read/write access on the user account associated with :user_key
          @auth = {:app_key => auth_tokens[:app_key], :user_key => auth_tokens[:user_key]}
        elsif auth_tokens.include?(:user) && auth_tokens.include?(:password)
          # read/write access on the user account matching this login info 
          @auth = {:app_key => auth_tokens[:app_key], :user => auth_tokens[:user], :password => auth_tokens[:password]}
        else
          # read-only access to public data
          @auth = {:app_key => auth_tokens[:app_key]}
        end
      end 
    end
  end

  # available API request methods are documented at:
  # http://developer.eventbrite.com/doc
  def method_request( method, params )
    #merge auth params into our request querystring
    querystring = @auth.merge( params.is_a?(Hash) ? params : {} )
    method_header = method.to_s.split('_')
    resp = self.class.get("/v3/#{method_header.first}/#{method_header.last}",{:query => querystring})

    if resp['error']
      raise RuntimeError, resp['error']['error_message'], caller[1..-1]
    end
    return resp
  end

  def method_missing(method, *args, &block)
    self.method_request(method, args[0])
  end
end

