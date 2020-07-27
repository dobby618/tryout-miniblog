# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    article
    user
    body { Faker::String.random }
  end
end
