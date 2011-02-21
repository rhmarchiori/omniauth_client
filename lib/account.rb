require 'omniauth/oauth'
require 'multi_json'

module OmniAuth
 module Strategies
   
  class Account < OAuth2

   def initialize(app, api_key = nil, secret_key = nil, options = {}, &block)
     client_options = {
      :site => 'http://localhost:3000',
      :authorize_url => "http://localhost:3000/auth/account/authorize",
      :access_token_url => "http://localhost:3000/auth/account/access_token"
     }
     super(app, :account, api_key, secret_key, client_options, &block)
   end

protected

   def user_data
     @data ||= MultiJson.decode(@access_token.get("/auth/account/user.json"))
   end

   def request_phase
     options[:scope] ||= "read"
     super
   end

   def user_hash
     user_data
   end

   def auth_hash
     OmniAuth::Utils.deep_merge(super, {
       'uid' => user_data["uid"],
       'user_info' => user_data['user_info']
       }
      )
   end
  end
 end
end
