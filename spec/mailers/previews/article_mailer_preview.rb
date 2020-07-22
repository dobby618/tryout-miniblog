# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/article_mailer
class ArticleMailerPreview < ActionMailer::Preview
  def commented
    ArticleMailer.commented(Article.first, Article.first.comments.last)
  end
end
