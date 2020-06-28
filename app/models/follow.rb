# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :follow_user, class_name: 'User'

  validates :user, uniqueness: { scope: :follow_user }
end
