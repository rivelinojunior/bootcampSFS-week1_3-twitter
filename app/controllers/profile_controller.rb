class ProfileController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    @hashtags = Tweet.tag_counts_on(:hashtags)
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end
end
