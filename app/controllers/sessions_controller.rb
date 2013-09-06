class SessionsController < ApplicationController
  skip_before_filter :set_oauth_tokens

  def create
    user = update_user
    #FIXME: Redirect to the url the user came from at the start of the auth flow
    redirect_to "http://localhost:3001/#/token/#{user.oauth_token}"
  end

private

  def update_user
    user = User.where(nickname: auth_hash.info.nickname).first
    unless user
      user = User.new
    end
    user.update_attributes(user_attributes)
    user
  end

  def user_attributes
    info = auth_hash.info
    creds = auth_hash.credentials
    {
      oauth_token: creds.token,
      oauth_token_secret: creds.secret,
      nickname: info.nickname,
      name: info.name,
      avatar_url: info.image,
      location: info.location,
      website: info.urls.Website,
      description: info.description
    }
  end

  def auth_hash
    request.env['omniauth.auth']
  end


end
