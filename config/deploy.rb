set :webfaction_username, "jingweno"
set :user, "#{webfaction_username}"
set :use_sudo, false

set :application, "ijws"
set :deploy_to, "/home/#{webfaction_username}/webapps/#{application}"

set :scm, "git" 
set :scm_user, "jingweno"
set :scm_password, Proc.new { Capistrano::CLI.password_prompt("Git password for #{scm_user}: ") }
set :repository,  "git@github.com:#{user}/#{application}.git"
set :repository_cache, "git_cache"
set :scm_verbose, true
set :branch, 'master'
ssh_options[:forward_agent] = true

set :domain, "ijws.it"

role :web, domain                         # Your HTTP server, Apache/etc
role :app, domain                         # This may be the same as your `Web` server
role :db,  domain, :primary => true       # This is where Rails migrations will run

set :deploy_via, :remote_cache 

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start, :roles => :app do
    invoke_command "#{deploy_to}/bin/start"
  end
  task :stop, :roles => :app do 
    invoke_command "#{deploy_to}/bin/stop"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    invoke_command "#{deploy_to}/bin/restart"
  end
end