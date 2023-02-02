# frozen_string_literal: true

class ApplicationController < ActionController::API
  include JsonWebToken
  include UserRole

  before_action :authenticate_request

  rescue_from ::DepositError, with: :deposit_error_handler

  private

  def authenticate_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    decoded = jwt_decode(header)
    @current_user = User.find_by(username: decoded[:username])
  end

  def deposit_error_handler(exception)
    render json: { message: exception.message, code: exception.code }, status: exception.http_status
  end
end
