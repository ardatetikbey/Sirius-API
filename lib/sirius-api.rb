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

  def self.register(email, username, password, first_name, last_name, birthdate)
    begin
      # Uzantıları barındıran kümeden ilgili apinin alınması
      uri = URIS[:register]

      # HTTP nesnesinin tanımlanması
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true # SSL kullanımı aktif edilir
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE # SSL için herhangi bir doğrulama yapılmasın

      # Request tanımlanması ve header verilmesi
      request = Net::HTTP::Post.new(uri.path, {
        "Content-Type" => "application/json"
      })

      # Data isimli bir sözlük oluşturulur
      # Fonksiyondan gelen veriler ile eşleştirilir
      data = {
        "email" => email,
        "username" => username,
        "password" => password,
        "firstName" => first_name,
        "lastName" => last_name,
        "birthdate" => birthdate
      }

      # İstek gövdesine veri json olarak eklenir
      request.body = data.to_json

      # Oluşturulan http nesnesi ile tanımlanan istek gönderilir
      response = http.request(request)

      # response döndürülür
      return response
    rescue Exception => err
      # hata yakalama bloğu
      puts "Error: #{err}"

      # hata varsa boş veri döndür
      return nil
    end
  end
end