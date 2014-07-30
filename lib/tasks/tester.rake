namespace :tester do
  desc 'first test task'  
  task first: :environment do
    start_task do
      puts "first_task"
    end
  end

  desc 'second test task'
  task second: :environment do
    start_task do
      puts "second_task"
    end
  end
  
  desc 'buggy task'
  task bug: :environment do
    start_task do
      what?
    end
  end
  
  def start_task(&block)
    yield
  rescue
    puts "rescued"
  end

end
