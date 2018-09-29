namespace :stock do
  task :refresh => :environment do
    stock = Stock.order(:updated_at).limit(1).first
    stock.fetch()
  end

  task :seed => :environment do
    require 'csv'
    csv_text = File.read(Rails.root.join('lib', 'seeds', 'volume-09-28-2018.csv'))
    csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
    csv.each do |row|
      puts Stock.find_or_create_by(ticker: row["Symbol"].downcase)
    end
  end
end
