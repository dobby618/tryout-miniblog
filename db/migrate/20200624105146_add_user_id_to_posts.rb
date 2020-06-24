# frozen_string_literal: true

class AddUserIdToPosts < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :user, null: false, foreign_key: true, after: :body # rubocop:disable Rails/NotNullColumn
  end
end
