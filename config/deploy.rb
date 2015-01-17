require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'
# require 'mina_sidekiq/tasks'

#                                                                        Config
# ==============================================================================
set :term_mode,       nil #Fix for password prompt
set :rails_env,       'production'

set :domain,          '104.130.200.148'
# set :port,            37894

set :deploy_to,       "/home/rails/apps/organizor"
set :app_path,        "#{deploy_to}/current"

set :repository,      'https://github.com/beck03076/organizor.git'
set :branch,          'redesign-new'

set :user,            'rails'
set :shared_paths,    ['config/database.yml', 'log' 'tmp']
set :keep_releases,   5

#                                                                           Rbenv
# ===============================================================================
# set :rbenv_path, '/home/deployer/.rbenv' not required when installed in default
#                                          folder structure

task :environment do
  invoke :'rbenv:load'
end

#                                                                    Setup task
# ==============================================================================
task :setup do

  queue! %[mkdir -p "#{deploy_to}/shared/tmp/pids"]

  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[touch "#{deploy_to}/shared/config/database.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/database.yml'."]

  queue! "sudo ln -nfs #{deploy_to}/current/config/apache.conf /etc/apache2/sites-enabled/organizor.org"

end

#                                                                   Deploy task
# ==============================================================================
desc "deploys the current version to the server."
task :deploy => :environment do
  deploy do
    invoke :'git:clone'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:link_shared_paths'
    # invoke :'sidekiq:quiet'

    to :launch do
      invoke :'unicorn:restart'
      # invoke :'sidekiq:restart'
    end
  end
end

#                                                                       Unicorn
# ==============================================================================
namespace :unicorn do
  set :unicorn_pid, "#{deploy_to}/shared/tmp/pids/unicorn.pid"
  set :start_unicorn, %{
    cd #{app_path}
    bundle exec unicorn -c #{app_path}/config/unicorn.rb -E #{rails_env} -D
  }

  #                                                                    Start task
  # ------------------------------------------------------------------------------
  desc "Start unicorn"
  task :start => :environment do
    queue 'echo "-----> Start Unicorn"'
    queue! start_unicorn
  end

  #                                                                     Stop task
  # ------------------------------------------------------------------------------
  desc "Stop unicorn"
  task :stop do
    queue 'echo "-----> Stop Unicorn"'
    queue! %{
      test -s "#{unicorn_pid}" && kill -QUIT `cat "#{unicorn_pid}"` && echo "Stop Ok" && exit 0
      echo >&2 "Not running"
    }
  end

  #                                                                  Restart task
  # ------------------------------------------------------------------------------
  desc "Restart unicorn using 'upgrade'"
  task :restart => :environment do
    invoke 'unicorn:stop'
    invoke 'unicorn:start'
  end
end
