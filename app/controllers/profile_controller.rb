# frozen_string_literal: true

class ProfileController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_user, only: [:show]

  def show
    @articles = Article.where(user_id: @user.follow_users.pluck(:id))
                       .includes(:user).order(created_at: :desc)
  end

  private

  def set_user
    @user = User.find_by!(name: params[:name])
  end
end
