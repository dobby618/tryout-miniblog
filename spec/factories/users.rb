# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Alphanumeric.alpha(number: 10) }
    email { Faker::Internet.email }
    password { Faker::Alphanumeric.alpha(number: 10) }
    profile { Faker::String.random }
    website { Faker::Internet.url }
  end
end
