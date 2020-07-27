# frozen_string_literal: true

class ArticleMailer < ApplicationMailer
  default template_path: "mailers/#{name.underscore}"

  def commented(article, comment)
    @article = article
    @comment = comment

    mail(to: article.user.email, subject: 'コメントが届きました')
  end

  def like_ranking_of_yesterday(to_user, articles)
    @articles = articles

    mail(to: to_user.email, subject: '昨日の「いいね」ランキング！')
  end
end
