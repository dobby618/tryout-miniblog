# frozen_string_literal: true

class AddArticleCommentsCountToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :comments_count, :integer, null: false, default: 0, after: :likes_count
  end
end
