# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :body, presence: true,
                   length: { maximum: 140 }

  def liked?(user)
    !likes.find_by(user: user).nil?
  end
end
