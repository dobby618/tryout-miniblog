# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :article, counter_cache: true
  belongs_to :user

  validates :body, presence: true
end
