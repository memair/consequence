class Troll < FrozenRecord::Base
  self.base_path = 'db/data'
  
  def get_tweet_id(twitter_client)
    recent_tweets = twitter_client.user_timeline(self.twitter_id)
    ordered_tweets = recent_tweets.sort_by { |t| t.retweet? ? 1 : 0 }
    ordered_tweets.first.id
  end
end
