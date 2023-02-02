# frozen_string_literal: true

class Product < ApplicationRecord
  validates :amount_available, presence: true
  validates :cost, presence: true
  validates :product_name, presence: true
  validates :seller_id, presence: true

  validate :cost_multiple_of_five

  belongs_to :seller, class_name: 'User'

  def cost_multiple_of_five
    return if (cost % 5).zero?

    errors.add(:cost, 'should be multiple of 5')
  end
end
