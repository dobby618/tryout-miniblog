# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    article
    user
    body { Faker::Name.name }
  end
end
