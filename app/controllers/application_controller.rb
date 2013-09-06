class ApplicationController < ActionController::Base
  before_filter :set_oauth_tokens

private

  def twitter_client
    Twitter::Client.new(
      oauth_token: @oauth_token,
      oauth_token_secret: @oauth_token_secret
    )
  end

  def set_oauth_tokens
    oauth_token = request.headers['X-OAuth-Token']
    user = User.where(oauth_token: oauth_token).first
    unless user
      raise Exception, "User with passed OAuth Token not found"
    end

    @oauth_token ||= user.oauth_token
    @oauth_token_secret ||= user.oauth_token_secret
  end

  def cache_key(*fragments)
    common_fragments = [@oauth_token, params[:controller], params[:action]]
    logger.debug "Cache key: #{fragments.concat(common_fragments)}"
    fragments.concat(common_fragments)
  end

end
