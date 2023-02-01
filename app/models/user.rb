# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  ROLES = %w[buyer seller].freeze

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  validates :role, presence: true

  validate :valid_role

  has_many :products

  def valid_role
    return unless ROLES.include?(role)

    errors.add(:role, 'must be "buyer" or "seller"')
  end
end
