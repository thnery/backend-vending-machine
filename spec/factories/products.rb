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

  factory(:guitar, class: Product) do
    product_name { 'Guitar Fender Stratocaster Custom Shop' }
    cost { 1000 }
    amount_available { 5 }
  end

  factory(:bass, class: Product) do
    product_name { 'Bass Fender Geddy Lee Signature' }
    cost { 5000 }
    amount_available { 1 }
  end
end
