# frozen_string_literal: true

FactoryBot.define do
  factory(:bread, class: Product) do
    product_name { 'bread' }
    cost { 25 }
    amount_available { 10 }
  end

  factory(:cheese, class: Product) do
    product_name { 'cheese' }
    cost { 10 }
    amount_available { 2 }
  end
end
