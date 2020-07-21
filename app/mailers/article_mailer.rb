# frozen_string_literal: true

class ArticleMailer < ApplicationMailer
  default template_path: "mailers/#{name.underscore}"

  def commented(article, comment)
    @article = article
    @comment = comment

    mail(to: article.user.email, subject: 'コメントが届きました')
  end
end
