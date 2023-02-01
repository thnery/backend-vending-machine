# frozen_string_literal: true

class ApplicationController < ActionController::API
  include JsonWebToken

  before_action :authenticate_request

  private

  def authenticate_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    decoded = jwt_decode(header)
    @current_user = User.find_by(username: decoded[:username])
  end
end

