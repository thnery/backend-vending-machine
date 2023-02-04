# frozen_string_literal: true

FactoryBot.define do
  factory(:seller, class: User) do
    username { "#{Faker::Name.first_name}_#{Faker::Name.last_name}".downcase }
    password { Faker::Internet.password }
    role { 'seller' }
  end

  factory(:buyer_with_balance, class: User) do
    username { "#{Faker::Name.first_name}_#{Faker::Name.last_name}".downcase }
    password { Faker::Internet.password }
    role { 'buyer' }
    deposit { 200 }
  end

  factory(:buyer_without_balance, class: User) do
    username { "#{Faker::Name.first_name}_#{Faker::Name.last_name}".downcase }
    password { Faker::Internet.password }
    role { 'buyer' }
    deposit { 0 }
  end
end
