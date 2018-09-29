namespace :option do
  task :clean => :environment do
    Option.where('expires_at < ?', Time.now).destroy_all
  end
end