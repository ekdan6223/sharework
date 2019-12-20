# frozen_string_literal: true
# config valid only for current version of Capistrano
# lock '3.11.0'
set :application, 'sharework'
set :repo_url, 'git@github.com:ekdan6223/sharework.git'
set :deploy_to, '/home/deploy/sharework'
append :linked_files, 'config/database.yml', 'config/master.key', 'config/application.yml'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads'
# Path of tests to be run, use array with empty string to run all tests
set :tests, ['']
namespace :deploy do
  # desc "Runs test before deploying, can't deploy unless they pass"
  #
  # task :run_tests do
  #   run_locally do
  #     test_log = 'log/capistrano.test.log'
  #     tests = fetch(:tests)
  #     tests.each do |test|
  #       info "--> Running tests locally: '#{test}', please wait ..."
  #       unless test(:rspec, "--tag ~js #{test}  > #{test_log} 2>&1")
  #         warn "--> Tests: '#{test}' failed. Results in: #{test_log} and below:"
  #         execute :cat, test_log
  #         exit
  #       end
  #       info "--> '#{test}' passed"
  #     end
  #     info '--> All tests passed'
  #     execute :rm, test_log
  #   end
  # end
  #
  # before :deploy, 'deploy:run_tests'
end
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"
# Default value for :format is :airbrussh.
# set :format, :airbrussh
# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto
# Default value for :pty is false
# set :pty, true
# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"
# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }
# Default value for keep_releases is 5
# set :keep_releases, 5