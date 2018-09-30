require 'sidekiq'
require 'sidekiq/web'

Sidekiq.configure_client do |config|
  config.redis = { url: Rails.application.secrets.redis_url }
end

Sidekiq.configure_server do |config|
  config.redis = { url: Rails.application.secrets.redis_url }
  config.average_scheduled_poll_interval = 5
end

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == [Rails.application.secrets.sidekiq_username, Rails.application.secrets.sidekiq_password]
end

if %W(staging production).include?(Rails.env)
  Sidekiq::Cron::Job.load_from_hash YAML.load_file("config/schedule.yml")
end