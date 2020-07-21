# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_article

  def index
  end

  def create
    comment = @article.comments.create(comment_params)

    if comment.errors.blank?
      # 自分の投稿にコメントした場合は、メール通知しない
      # 自分だったら他人にしたくない？
      ArticleMailer.commented(@article, comment).deliver_now if @article.user != current_user
    else
      flash[:alert] = comment.errors.full_messages
    end

    redirect_back fallback_location: root_url
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:body).merge(user: current_user)
  end
end
