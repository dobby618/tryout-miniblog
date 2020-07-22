# frozen_string_literal: true

class Article < ApplicationRecord
  mount_uploader :image, ArticleImageUploader

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :body, presence: true,
                   length: { maximum: 140 }

  def liked?(user)
    !likes.find_by(user: user).nil?
  end
end
