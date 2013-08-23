class HomeController < ApplicationController
  respond_to :json

  def index
    cached_home_timeline = cache(cache_key) { home_timeline }
    respond_with cached_home_timeline
  end

private
  def home_timeline
    logger.debug "TWITTER/HOME_TIMELINE"
    twitter_client.home_timeline
  end

end

