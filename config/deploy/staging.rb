$:.unshift(File.expand_path("~/.rvm/lib"))
require 'rvm/capistrano'
set :rvm_ruby_string, '1.9.2'
set :rvm_type, :user
# rvm bin path conflicts with rvm capistrano plugin
set :rvm_bin_path, File.expand_path("/home/ec2-user/bin") 
#############################################################
#	Application
#############################################################

set :application, "pig_fish_bank"
set :deploy_to,  "/web/sites/#{application}"


#############################################################
#	Settings
#############################################################

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:keys] = ["ec2.pem"]
set :use_sudo, true

set :rails_env, "staging"

#############################################################
#	Servers
#############################################################

set :user, "ec2-user"

role :web, "50.19.233.96"                          # Your HTTP server, Apache/etc
role :app, "50.19.233.96"                          # This may be the same as your `Web` server
role :db,  "50.19.233.96", :primary => true # This is where Rails migrations will run


#############################################################
#	SCM
#############################################################

set :scm, :git
set :scm_verbose, true
set :deploy_via, :remote_cache
set :repository, "git@github.com:lannon/pig_fish_bank.git"


namespace :deploy do
  
  
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

