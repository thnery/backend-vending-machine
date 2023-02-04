# frozen_string_literal: true

FactoryBot.define do
  factory(:bread, class: Product) do
    product_name { 'bread' }
    cost { 25 }
    amount_available { 10 }
  end
end
