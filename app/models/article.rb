# frozen_string_literal: true

class Article < ApplicationRecord
  LIKE_RANKING_LIMIT_OF_YESTERDAY = 10
  mount_uploader :image, ArticleImageUploader

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :body, presence: true,
                   length: { maximum: 140 }

  # rake タスク
  # rails cron:notify_like_ranking_of_yesterday
  def self.notify_like_ranking_of_yesterday
    ranked_articles = like_ranking_of_yesterday
    return if ranked_articles.count.zero?

    User.all.find_each do |user|
      ArticleMailer.like_ranking_of_yesterday(user, ranked_articles).deliver_now
    end
  end

  def self.like_ranking_of_yesterday(limit = LIKE_RANKING_LIMIT_OF_YESTERDAY)
    article_ids = Like.yesterday.group(:article_id).order(count_all: :desc).count.keys.take(limit)
    where(id: article_ids).order([Arel.sql('field(id, ?)'), article_ids])
  end

  def liked?(user)
    !likes.find_by(user: user).nil?
  end
end
