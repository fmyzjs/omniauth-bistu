require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Bistu < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site => 'https://222.249.250.89:8443/',
        :authorize_url => 'https://222.249.250.89:8443/oauth/authorize',
        :token_url => 'https://222.249.250.89:8443/oauth/token'
      }

      uid { raw_info['userName'] }

      info do
        {
          'email' => raw_info['email'],
          'name' => raw_info['realName'],
          'idtype' => raw_info['idType'],
          'username' => raw_info['userName'],
          'avatar' => raw_info['avatar'],
          'active' => raw_info['active']
        }
      end

      extra do
        {:raw_info => raw_info}
      end

      def raw_info
        #access_token.options[:mode] = :query
        @raw_info ||= access_token.get('/m/userinfo.htm', {:parse => :json}).parsed
      end
      
    end
  end
end

OmniAuth.config.add_camelization 'bistu', 'Bistu'
