# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :article, counter_cache: true

  validates :user, uniqueness: { scope: :article }

  scope :yesterday, -> { where(created_at: Time.current.ago(1.day).all_day) }
end
