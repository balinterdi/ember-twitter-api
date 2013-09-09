class Twitter::TweetsController < ApplicationController

  def create
    text = params[:text]
    tweet = twitter_client.update(text)
    render json: { tweet: { text: text } }
  end
end

