# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_product, only: %i[create update destroy]
  before_action :check_role, only: [:create]
  before_action :check_permission, only: %i[update destroy]

  def index

  end

  def create

  end

  def update

  end

  def destroy

  end

  private

  def set_product
    Product.find_by(id: params[:id])
  end

  def permission?
    seller? && product.seller_id.eq?(@current_user.id)
  end
end
