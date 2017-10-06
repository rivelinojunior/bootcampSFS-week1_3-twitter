class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tweets = Tweet.timeline current_user.id
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)

    respond_to do |format|
      if @tweet.save_with_hashtag
        format.html { redirect_to @tweet, notice: 'Your tweet has been posted!' }
        format.json { render :show , status: :created, location: @tweet}
      else
        format.html { render :new}
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to todo_items_url, notice: 'Your tweet has been destroyed.' }
      format.json { head :no_content }
    end
  end

  def like
    if @tweet.like current_user.id
      render json: true, status: :ok
    else
      render json: false, status: :unprocessable_entity
    end
  end

  def dislike
    if Tweet.dislike params[:id]
      render json: true, status: :ok
    else
      render json: false, status: :unprocessable_entity
    end
  end

  def search
    search_type = params[:type]
    query = params[:q]
    
    if(search_type == 'description')
      @tweets = Tweet.search(query)
    elsif(search_type == 'hashtag')
      @tweets = Tweet.search_by_hashtag(query)
    else
      @tweets = User.search_by_user(query)
    end
  end

  private
  def tweet_params
    params.permit(:description, :hashtag_list)
  end

  def set_tweet
    @tweet = Tweet.find_by params[:id]
  end

end
