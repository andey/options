class RefreshCron
  include Sidekiq::Worker
  sidekiq_options queue: :cronjobs, retry: true

  def perform
    Stock.order(:updated_at).limit(1).first.fetch()
  end
end