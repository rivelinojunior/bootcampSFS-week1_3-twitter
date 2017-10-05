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
      if @tweet.save
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


  private
  def tweet_params
    params.require(:tweet).permit(:description)
  end

end
