class UsersController < ApplicationController
  respond_to :json
  skip_before_filter :set_oauth_tokens, only: :create
  skip_before_filter :verify_oauth_token, only: :create

  def show
    cached_user = cache(cache_key) { logger.debug "TWITTER"; twitter_client.user }
    respond_with cached_user
  end

  def create
    user = User.where(nickname: params[:nickname]).first
    user = if user
      user.update_attributes(user_params)
      user
    else
      User.create!(user_params)
    end
    respond_with user
  end

  private
  def user_params
    params.permit(:oauth_token, :oauth_token_secret, :nickname, :name, :avatar_url, :location, :website, :description)
  end
end
