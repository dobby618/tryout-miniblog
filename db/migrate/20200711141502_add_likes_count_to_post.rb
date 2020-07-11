# frozen_string_literal: true

class AddLikesCountToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :likes_count, :integer, null: false, default: 0, after: :user_id

    # likes_count カラムに既存の「いいね」数を登録する
    Post.all.each do |post|
      Post.reset_counters(post.id, :likes)
    end
  end
end
