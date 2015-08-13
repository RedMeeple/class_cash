desc "This task is called by the Heroku scheduler add-on"
task :update_feed => :environment do
  puts "Updating feed..."
  NewsFeed.update
  puts "done."
end

task :save_all_balances => :environment do
  Student.save_all_balances
end

task :save_all_balances => :environment do
  Student.save_all_balances
end

task :update_balances => :environment do
  Loan.update_balances
end
