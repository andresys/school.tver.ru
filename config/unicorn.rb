root = "/var/www/school.tver.ru/app"
working_directory "#{root}/current"
pid "#{root}/tmp/unicorn.pid"
listen "#{root}/tmp/unicorn.sock"

stderr_path "#{root}/shared/log/unicorn.stderr.log"
stdout_path "#{root}/shared/log/unicorn.stdout.log"

worker_processes 4
timeout 30

# Force the bundler gemfile environment variable to
# reference the capistrano "current" symlink
before_exec do |_|
    ENV["BUNDLE_GEMFILE"] = File.join(root, 'Gemfile')
end