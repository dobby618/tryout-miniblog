# frozen_string_literal: true

class AddIndexToFllows < ActiveRecord::Migration[6.0]
  def change
    add_index :follows, [:user_id, :follow_user_id], unique: true
  end
end
