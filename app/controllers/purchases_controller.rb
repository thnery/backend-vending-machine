# frozen_string_literal: true

class PurchasesController < ApplicationController
  before_action :check_role, only: [:buy]

  def buy
    response = ::ProcessPurchaseService.call!(buy_params, @current_user)

    render json: { data: response[:data] }, status: response[:http_status]
  end

  private

  def buy_params
    params.permit(:product_id, :amount_of_products)
  end

  def check_role
    return if buyer?

    render json: { error: 'operation not permited' }, status: :forbidden
  end
end
