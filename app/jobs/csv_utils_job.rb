class CsvUtilsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts 'job started'
    count  = 0
    args[0].each do |row|
      puts " line: #{count} + #{row}"
      count = count +1
      m = Manager.new
      # row.each do |item|
       f_name = row[1]
      l_name = row[2]
      age = row[3]
      team_name = row[0]
      team = Team.create(name: team_name)
      m = Manager.create(first_name: f_name, last_name: l_name, age: age, team_id: team.id)
      # end
    end
    puts 'job finished'
    TeamMailer.send_rep_with_managers_and_teams(count).deliver_later
  end
end
