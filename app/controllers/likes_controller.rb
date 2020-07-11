# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_post
  before_action :others_post?, only: [:create]

  def show
    @users = User.where(id: @post.likes.pluck(:user_id))
  end

  def create
    like = current_user.likes.find_by(post: @post)
    Like.create(post: @post, user: current_user) unless like

    redirect_back fallback_location: root_url
  end

  def destroy
    like = current_user.likes.find_by(post: @post)
    like&.destroy

    redirect_back fallback_location: root_url
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def others_post?
    return unless @post.user == current_user

    redirect_back fallback_location: root_url, alert: '自分の投稿には「いいね」できません'
  end
end
