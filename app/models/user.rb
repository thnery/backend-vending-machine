# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  ROLES = %w[buyer seller].freeze

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  validates :role, presence: true

  validate :valid_role

  has_many :products

  def buyer?
    role.eql? 'buyer'
  end

  def seller?
    role.eql? 'seller'
  end

  def make_deposit(amount)
    amount = amount.to_i

    raise DepositError, 'negative amount not allowed' if amount.negative?
    raise DepositError, 'amount not allowed, please use multiples of 5' unless (amount % 5).zero?
    raise DepositError, 'maximum deposit should be 100' if amount > 100

    puts deposit
    puts amount

    update_attribute(:deposit, deposit + amount)
  end

  def reset_deposit
    update_attribute(:deposit, 0)
  end

  protected

  def valid_role
    return if ROLES.include?(role)

    errors.add(:role, 'must be "buyer" or "seller"')
  end
end
