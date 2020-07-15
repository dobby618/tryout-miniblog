# frozen_string_literal: true

class FollowsController < ApplicationController
  before_action :set_follow

  def create
    Follow.create(user_id: current_user.id, follow_user_id: params[:user_id]) unless @follow

    redirect_to profile_path(current_user.name)
  end

  def destroy
    @follow&.destroy

    redirect_back fallback_location: root_url
  end

  private

  def set_follow
    @follow = current_user.follows.find_by(follow_user_id: params[:user_id])
  end
end
