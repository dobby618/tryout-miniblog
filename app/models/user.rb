# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :validatable, authentication_keys: [:name]

  has_many :posts, dependent: :destroy

  validates :name, length: { maximum: 20 },
                   format: { with: /\A[a-zA-Z]+\z/ },
                   uniqueness: { case_sensitive: false }
  validates :url, format: /\A#{URI.regexp(%w[http https])}\z/, allow_blank: true

  def email_required?
    false
  end
end
