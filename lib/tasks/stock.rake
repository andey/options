namespace :stock do
  task :refresh => :environment do
    stock = Stock.order(:updated_at).limit(1)
    stock.fetch()
  end
end
