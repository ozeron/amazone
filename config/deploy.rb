# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'amazone'
set :user, 'deployer'
set :repo_url, "git@github.com:ozeron/#{fetch(:application)}.git"


# rbenv
set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.3.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'
set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, 'config/database.yml', 'config/secrets.yml'
set :linked_files, %w(config/database.yml config/secrets.yml)

# Default value for linked_dirs is []
# append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'
set :linked_dirs, %w(log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system)

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 10

# Global SSH options
set :ssh_options, {
  forward_agent: true
}

namespace :rails do
  desc "Open the rails console on one of the remote servers"
  task :console do
    on roles(:app) do
      puts "Connecting to: #{fetch(:user)}@#{fetch(:domain_app)}"
      exec "ssh -l #{fetch(:user)} #{fetch(:domain_app)} -t 'source ~/.profile && cd #{current_path} && bin/rails console #{fetch(:rails_env)}'"
    end
  end
end
