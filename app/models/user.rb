# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :validatable, authentication_keys: [:name]

  has_many :posts

  validates :name, length: { maximum: 20 },
                   format: { with: /\A[a-zA-Z]+\z/ },
                   uniqueness: true

  def email_required?
    false
  end
end
