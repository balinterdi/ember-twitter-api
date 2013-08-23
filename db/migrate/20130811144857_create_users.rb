class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |u|
      u.string :nickname
      u.string :name
      u.text   :oauth_token
      u.text   :oauth_token_secret
      u.text   :avatar_url
      u.text   :location
      u.text   :website
      u.text   :description

      u.timestamps
    end
  end
end

