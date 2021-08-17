class HomeController < ApplicationController
    before_action :authenticate_user! , only: [:new,:create]

  def index
    if params[:keyword].present?
      @tweets = Tweet.where("body like (?)","%params[:keyword]%")
    else  
      @tweets = Tweet.all
    end
  end
 
  def new
     @tweet = Tweet.new
  end
 
  def create
     @tweet = Tweet.new(tweet_params)
     @tweet.user_id = current_user.id
    if @tweet.save
      redirect_to '/home#index'
     else
       render 'new'
    end
  end

  def comment
  end
 
  private
  def tweet_params
    params.require(:tweet).permit(:body)
  end
end