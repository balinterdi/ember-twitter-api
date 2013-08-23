class Twitter::TimelinesController < ApplicationController
  respond_to :json

  def home
    cached_home_timeline = cache(cache_key) { home_timeline }
    respond_with cached_home_timeline
  end

  def show
    cached_user_timeline = cache(cache_key(params[:id])) do
      user_timeline(params[:id])
    end
    respond_with cached_user_timeline
  end

  private
  def home_timeline
    logger.debug "TWITTER/HOME_TIMELINE"
    twitter_client.home_timeline
  end

  def user_timeline(screen_name)
    logger.debug "TWITTER/USER_TIMELINE"
    twitter_client.user_timeline(screen_name)
  end
end

