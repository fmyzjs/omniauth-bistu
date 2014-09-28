require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Bistu < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site => 'https://222.249.250.89:8443/',
        :authorize_url => 'https://222.249.250.89:8443/oauth/authorize',
        :token_url => 'https://222.249.250.89:8443/oauth/token'
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

      uid do
        raw_info['userid']
      end

      info do
        {
          'email' => email,
          'name' => raw_info['username'],
          'idtype' => raw_info['idtype'],
          'username'=> raw_info['userid'],
        }
      end

      extra do
        {:raw_info => raw_info}
      end

      def raw_info
        #access_token.options[:mode] = :query
        @raw_info ||= access_token.get('/m/userinfo.htm').parsed
      end
      
      def email
        if raw_info['idtype']=='J0000' || raw_info['idtype']=='JH001'
          @email=raw_info['userid']+'@'+'bistu.edu.cn'
        else
          @email=raw_info['userid']+'@'+'mail.bistu.edu.cn'
        end
      end
      
    end
  end
end

OmniAuth.config.add_camelization 'bistu', 'Bistu'
