# frozen_string_literal: true

# JsonWebToken handles JWT methods
class JsonWebToken
  SECRET_KEY = ENV['SECRET_KEY']

  def self.encode(payload, exp = 48.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end

  def self.renew(token, exp = 48.hours.from_now)
    decoded = HashWithIndifferentAccess.new JWT.decode(token, SECRET_KEY)[0]
    decoded[:exp] = exp.to_i
    token = JWT.encode(decoded, SECRET_KEY)
    { token: token, exp: Time.at(decoded[:exp]).to_datetime }
  end
end
