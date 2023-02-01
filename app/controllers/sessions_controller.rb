# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate_request

  def create
    @user = User.find_by(username: params[:username])

    if @user&.authenticate(params[:password])
      token = jwt_encode(username: @user.username)
      render json: { token: }, status: :ok
    else
      render json: { error: :unauthorized }, status: :unauthorized
    end
  end
end


