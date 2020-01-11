class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:memair, :twitter]

  has_many :goals

  def self.from_memair_omniauth(omniauth_info)
    data        = omniauth_info.info
    credentials = omniauth_info.credentials

    user = User.where(email: data['email']).first

    unless user
      user = User.create(
        email:    data['email'],
        password: Devise.friendly_token[0,20]
      )
    end

    user.memair_access_token = credentials['token']
    user.save
    user
  end

  def twitter_client()
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_API_KEY']
      config.consumer_secret     = ENV['TWITTER_API_SECRET']
      config.access_token        = self.twitter_access_token
      config.access_token_secret = self.twitter_access_token_secret
    end
    client
  end

  def retweet()
    client = self.twitter_client
    tweet_id = 1211052127180603393
    client.retweet(tweet_id)
  end

  private

    def revoke_memair_token
      puts "revoking Memair token"
      user = Memair.new(self.memair_access_token)
      query = 'mutation {RevokeAccessToken{revoked}}'
      user.query(query)
    end
end
