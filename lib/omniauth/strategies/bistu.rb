require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Bistu < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site => 'http://222.249.250.234/u/',
        :authorize_url => 'http://222.249.250.234/o/authorize/',
        :token_url => 'http://222.249.250.234/o/token/'
      }

      def request_phase
        super
      end
      
      def authorize_params
        super.tap do |params|
          %w[scope client_options].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end
        end
      end

      uid { raw_info['id'].to_s }

      info do
        {
          'nickname' => raw_info['userid'],
          'email' => raw_info['email'],
          'name' => raw_info['username'],

        }
      end

      extra do
        {:raw_info => raw_info}
      end

      def raw_info
        #access_token.options[:mode] = :query
        @raw_info ||= access_token.get('/bistuapi/me/').parsed
      end

    end
  end
end

OmniAuth.config.add_camelization 'bistu', 'Bistu'
