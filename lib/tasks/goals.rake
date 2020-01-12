desc "Check goals"
task :check_goals => :environment do
  goal = Goal.where('last_checked_at IS NULL OR last_checked_at < ?', 12.hours.ago).order('last_checked_at ASC NULLS FIRST').first
  unless goal.nil?
    puts "checking #{goal.name} for user #{goal.user.email}"
    
    begin
      if goal.failed?
        puts "retweeting #{goal.troll.name}"
        goal.user.retweet(goal.troll)
      else
        puts "goal not failed, good work"
      end
    rescue ArgumentError => error
      puts error.message
    end
    goal.touch(:last_checked_at)
  else
    puts "no goals needing actioning"
  end
end