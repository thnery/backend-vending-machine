# frozen_string_literal: true

module JwtHelper
  def self.encode(payload, secret)
    JWT.encode(payload, secret)
  end

  def self.decode(token, secret)
    JWT.decode(token, secret, true, { algorithm: 'HS256' })
  end
end
