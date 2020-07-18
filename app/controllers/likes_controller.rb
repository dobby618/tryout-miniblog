# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_article
  before_action :others_article?, only: [:create]

  def show
    @users = User.where(id: @article.likes.pluck(:user_id))
  end

  def create
    like = current_user.likes.find_by(article: @article)
    Like.create(article: @article, user: current_user) unless like

    redirect_back fallback_location: root_url
  end

  def destroy
    like = current_user.likes.find_by(article: @article)
    like&.destroy

    redirect_back fallback_location: root_url
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def others_article?
    return unless @article.user == current_user

    redirect_back fallback_location: root_url, alert: '自分の投稿には「いいね」できません'
  end
end
