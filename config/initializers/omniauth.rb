Rails.application.config.middleware.use OmniAuth::Builder do
  provider :memair, ENV['MEMAIR_CLIENT_ID'], ENV['MEMAIR_CLIENT_SECRET'], scope: 'biometric_read digital_activity_read physical_activity_read medication_read insight_read'
  provider :twitter, ENV['TWITTER_API_KEY'], ENV['TWITTER_API_SECRET'], {scope: 'read write'}
end
