# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_product, only: %i[create update destroy]
  before_action :check_role, only: [:create]
  before_action :check_permission, only: %i[update destroy]

  def index
    products = Product.all

    render json: { products: }, status: :ok
  end

  def create
    product = Product.new(product_params)
    product.seller_id = @current_user.id

    if product.save
      render json: { product: }, status: :created
    else
      render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: { product: @product }
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @product.destroy
      render json: { message: 'Product sucessfully deleted' }, status: :ok
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = Product.find_by(id: params[:id])
  end

  def product_params
    params.permit(:product_name, :cost, :amount_available)
  end

  def check_permission
    return if seller? && @product.seller_id.eql?(@current_user.id)

    render json: { error: 'opperation not permited' }, status: :forbidden
  end

  def check_role
    return if seller?

    render json: { error: 'operation not permited' }, status: :forbidden
  end
end
