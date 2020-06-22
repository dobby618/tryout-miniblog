# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    body { Faker::Name.name }
  end
end
