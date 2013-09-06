class Twitter::UsersController < ApplicationController
  respond_to :json

  def show
    cached_user = cache(cache_key) { logger.debug "TWITTER/USER_INFO"; twitter_client.users(params[:id]).first }
    respond_with cached_user
  end
end

