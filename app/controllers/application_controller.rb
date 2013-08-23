class ApplicationController < ActionController::Base
  before_filter :set_oauth_tokens
  before_filter :verify_oauth_token

private

  def twitter_client
    Twitter::Client.new(
      oauth_token: @oauth_token,
      oauth_token_secret: @oauth_token_secret
    )
  end

  def set_oauth_tokens
    user ||= User.find(user_id)
    @oauth_token ||= user.oauth_token
    @oauth_token_secret ||= user.oauth_token_secret
  end

  def verify_oauth_token
    unless @oauth_token and @oauth_token_secret
      #TODO: Make this a proper Access Denied
      raise "You need an oauth token to make requests to Twitter"
    end
  end

  def cache_key(*fragments)
    common_fragments = [@oauth_token, params[:controller], params[:action]]
    logger.debug "Cache key: #{fragments.concat(common_fragments)}"
    fragments.concat(common_fragments)
  end

  def user_id
    controller = 'users' ? params[:id] : params[:user_id]
  end

end
