# frozen_string_literal: true

class ProcessPurchaseService
  def initialize(params, buyer)
    @product_id = params[:product_id]
    @amount = params[:amount_of_products].to_i
    @buyer = buyer
  end

  def call!
    raise PurchaseError, 'not enough balance' if @buyer.deposit.zero?

    @product = Product.find_by(id: @product_id)

    raise PurchaseError, "current amount of #{@product.product_name} is #{@product.amount_available}" if @amount > @product.amount_available

    @total_cost = @product.cost * @amount

    raise PurchaseError, 'not enough balance' if @buyer.deposit < @total_cost

    @buyer.update_attribute(:deposit, @buyer.deposit - @total_cost)
    @product.update_attribute(:amount_available, @product.amount_available - @amount)

    render_response
  end

  def self.call!(params, buyer)
    new(params, buyer).call!
  end

  protected

  def render_response
    {
      data: {
        spent: @total_cost,
        product: @product.product_name,
        change: coin_change(@buyer.deposit)
      },
      http_status: :ok
    }
  end

  def coin_change(amount)
    coins = [5, 10, 20, 50, 100]
    minimum_coins = Array.new(amount + 1, Float::INFINITY)
    minimum_coins[0] = 0
    selected_coins = Array.new(amount + 1)

    (1..amount).each do |i|
      coins.each do |coin|
        if i >= coin && minimum_coins[i - coin] + 1 < minimum_coins[i]
          minimum_coins[i] = minimum_coins[i - coin] + 1
          selected_coins[i] = coin
        end
      end
    end

    minimum_coins[amount] == Float::INFINITY ? [] : get_coins(selected_coins, amount)
  end

  def get_coins(selected_coins, amount)
    result = []

    while amount.positive?
      result << selected_coins[amount]
      amount -= selected_coins[amount]
    end

    result
  end
end
