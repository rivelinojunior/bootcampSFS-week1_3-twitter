class TweetsController < ApplicationController
  before_action :set_tweet, only: [:like, :dislike, :destroy]
  before_action :authenticate_user!

  def index
    @tweets = Tweet.timeline current_user.id
    @hashtags = Tweet.tag_counts_on(:hashtags)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)
    respond_to do |format|
      if @tweet.save_with_hashtag
        format.html {redirect_to root_path, notice: 'Tweet was successfully created.'}
      else
        format.html {render :new}
        format.json {render json: @tweet.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html {redirect_to root_path, notice: 'Your tweet has been destroyed.'}
      format.json {head :no_content}
    end
  end

  def like
    @tweet.like current_user.id
    respond_to do |format|
      format.html {redirect_to root_path, notice: 'Tweet was like.'}
      format.json {head :no_content}
    end
  end

  def dislike
    @tweet.dislike current_user.id
    respond_to do |format|
      format.html {redirect_to root_path, notice: 'Tweet was dislike.'}
      format.json {head :no_content}
    end
  end

  def search
    query = params[:q]

    @tweets = Tweet.search(query)
    @users = User.search_by_user(query)
    @hashtags = Tweet.tag_counts_on(:hashtags)
  end

  private
  def tweet_params
    params.require(:tweet).permit(:description, :hashtag_list)
  end

  def set_tweet
    @tweet = Tweet.find_by id: params[:id]
  end

end
