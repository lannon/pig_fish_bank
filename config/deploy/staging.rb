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


namespace :deploy do
  
  task :fix_permissions, :roles => :app do
    sudo "chgrp nobody #{release_path}/public/stylesheets"
    sudo "chgrp nobody #{release_path}/tmp/cache"
  end
  
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

before 'deploy:symlink', 'deploy:fix_permissions'