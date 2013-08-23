class Twitter::UsersController < ApplicationController
  respond_to :json

  def show
    cached_user = cache(cache_key) { logger.debug "TWITTER/USER"; twitter_client.user }
    respond_with cached_user
  end
end
