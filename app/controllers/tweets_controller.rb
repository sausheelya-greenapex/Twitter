class TweetsController < ApplicationController
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
       redirect_to root_path
     else
       render 'new'
    end
  end

  def comment
    @tweet =  Tweet.find_by_id(params[:tweet_id])
    @comments = @tweet.comments
 end

    def create_comment
  	 comment = params[:body]
  	 tweet = Tweet.find_by_id(params[:tweet_id])
  	 p tweet
  	 p comment
  	 p current_user.id
  	  if comment and tweet
  	  	 Comment.create(body:params[:body],user_id:current_user.id,tweet_id:tweet.id)
  	  	   redirect_to root_path
  	  else
  	  	flash[:error] = "Something went Wrong"
  	  	  redirect_to root_path
  	  end
    end

  def retweet
    @tweet =Tweet.find_by_id(params[:tweet_id])
    if @tweet
      if  Retweet.find_by(user_id: current_user.id, tweet_id:@tweet.id)
          redirect_to root_path, alert: 'Already Retweeted'
      else
         @retweet = Retweet.create(user_id: current_user.id, tweet_id:@tweet.id)
          redirect_to root_path, alert: 'Retweeted'
      end
    else
      redirect_to root_path, alert: 'Tweet Not Found'
    end
  end
 
  private
  def tweet_params
    params.require(:tweet).permit(:body)
  end
end
