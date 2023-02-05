# frozen_string_literal: true

class Product < ApplicationRecord
  validates :amount_available, presence: true
  validates :cost, presence: true
  validates :product_name, presence: true
  validates :seller_id, presence: true

  validate :valid_cost

  belongs_to :seller, class_name: 'User'

  def valid_cost
    if (cost.nil? or cost.zero?)
      errors.add(:cost, 'cost cannot be zero or nil')
      return
    end

    if !(cost % 5).zero?
      errors.add(:cost, 'should be multiple of 5')
      return
    end
  end
end
