# frozen_string_literal: true

class ProfileController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_user, only: [:show]

  def show
    @posts = Post.where(user_id: @user.follow_users.pluck(:id))
                 .includes(:user).order(created_at: :desc)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
