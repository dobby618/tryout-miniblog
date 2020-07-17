# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :validatable, authentication_keys: [:name]

  has_many :articles,     dependent: :destroy
  has_many :likes,        dependent: :destroy
  has_many :follows,      dependent: :destroy
  has_many :follow_users, through: :follows
  has_many :followeds,    dependent: :destroy, inverse_of: :user,
                          foreign_key: :follow_user_id, class_name: 'Follow'
  has_many :followers,    through: :followeds, source: :user

  validates :name, length: { maximum: 20 },
                   format: { with: /\A[a-zA-Z]+\z/ },
                   uniqueness: { case_sensitive: false }
  validates :website, format: /\A#{URI.regexp(%w[http https])}\z/, allow_blank: true

  def email_required?
    false
  end

  def followed?(follow_user)
    !follows.find_by(follow_user_id: follow_user.id).nil?
  end
end
