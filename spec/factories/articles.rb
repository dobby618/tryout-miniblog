# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    user
    body { Faker::Name.name }
  end
end
