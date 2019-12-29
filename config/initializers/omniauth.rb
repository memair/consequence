Rails.application.config.middleware.use OmniAuth::Builder do
  provider :memair, ENV['MEMAIR_CLIENT_ID'], ENV['MEMAIR_CLIENT_SECRET'], scope: 'biometric_read digital_activity_read emotion_read journal_read location_read medication_read physical_activity_read user_details insight_read recommendation_read'
  provider :twitter, ENV['TWITTER_API_KEY'], ENV['TWITTER_API_SECRET'], { x_auth_access_type: 'read write' }
end
