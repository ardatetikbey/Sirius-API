require "net/http"
require "json"
require "uri"
require "openssl"

module SiriusApi
  URIS = {
    register: URI("https://api.socialsirius.store/api/v1/auth/register"),
    activate: URI("https://api.socialsirius.store/api/v1/auth/activate-user"),
    login: URI("https://api.socialsirius.store/api/v1/auth/login"),
    logout: URI("https://api.socialsirius.store/api/v1/auth/logout"),
    resend_activation: URI("https://api.socialsirius.store/api/v1/auth/resend-activation"),
    refresh_token: URI("https://api.socialsirius.store/api/v1/auth/refresh-token"),
    forgot_password: URI("https://api.socialsirius.store/api/v1/auth/forgot-password"),
    reset_password: URI("https://api.socialsirius.store/api/v1/auth/reset-password"),
  }

  class << self
    def register(email, username, password, first_name, last_name, birthdate)
      post(:register, {
        email: email,
        username: username,
        password: password,
        firstName: first_name,
        lastName: last_name,
        birthdate: birthdate
      })
    end

    def login(identifier, password)
      post(:login, {
        identifier: identifier,
        password: password
      })
    end

    def activate_user(token)
      post(:activate, { token: token })
    end

    def logout(token)
      post(:logout, { token: token })
    end

    def refresh_token(token)
      post(:refresh_token, { refreshToken: token })
    end

    def resend_activation(email)
      post(:resend_activation, { email: email })
    end

    def forgot_password(email)
      post(:forgot_password, { email: email })
    end

    def reset_password(token, password)
      post(:reset_password, {
        token: token,
        newPassword: password
      })
    end

    private

    def post(endpoint_key, data)
      uri = URIS[endpoint_key]
      http = build_http(uri)
      request = Net::HTTP::Post.new(uri.path, { "Content-Type" => "application/json" })
      request.body = data.to_json
      perform_request(http, request)
    end

    def build_http(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http
    end

    def perform_request(http, request)
      http.request(request)
    rescue StandardError => e
      warn "[SiriusApi Error] #{e.class}: #{e.message}"
      nil
    end
  end
end
