# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  before_action :check_role, only: %i[deposit reset]

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def deposit
    @current_user.make_deposit(deposit_params[:amount])

    render json: { message: 'deposit successfully done', current_balance: @current_user.deposit }, status: :ok
  end

  def reset
    @current_user.reset_deposit

    render json: { message: 'deposit reseted', current_balance: @current_user.deposit }, status: :ok
  end

  def update
    if @current_user.update_attributes(update_params)
      render json: @current_user, status: :ok
    else
      render json: { errors: @current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @current_user.destroy
      render json: { message: 'user removed' }, status: :ok
    else
      render json: { errors: @current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:username, :password, :role)
  end

  def update_params
    params.permit(:username)
  end

  def deposit_params
    params.permit(:amount)
  end

  def check_role
    return if buyer?

    render json: { error: 'operation not permited' }, status: :forbidden
  end

  def validate_user_delection
    
  end
end
