# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/article_mailer
class ArticleMailerPreview < ActionMailer::Preview
  def commented
    ArticleMailer.commented(Article.first, Article.first.comments.last)
  end

  def like_ranking_of_yesterday
    ArticleMailer.like_ranking_of_yesterday(User.first, Article.like_ranking_of_yesterday)
  end
end
