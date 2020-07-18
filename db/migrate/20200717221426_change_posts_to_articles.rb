# frozen_string_literal: true

class ChangePostsToArticles < ActiveRecord::Migration[6.0]
  def change
    rename_table :posts, :articles
    rename_column :likes, :post_id, :article_id
  end
end
