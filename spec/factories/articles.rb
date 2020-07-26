# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    user
    body { Faker::String.random }
  end
end
