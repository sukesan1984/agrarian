# -*- coding: utf-8 -*-
## ワーカーの数
#worker_processes 2
#
## ソケット
#listen  '/tmp/unicorn.sock'
#pid     '/tmp/unicorn.pid'
#
## ログ
#log = 'agrarian/log/unicorn.log'
#stderr_path File.expand_path('log/unicorn.log', ENV['RAILS_ROOT'])
#stdout_path File.expand_path('log/unicorn.log', ENV['RAILS_ROOT'])
#
#preload_app true
#GC.respond_to?(:copy_on_write_friendly=) and GC.copy_on_write_friendly = true
#
#before_fork do |server, worker|
#defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
#
#old_pid = "#{ server.config[:pid] }.oldbin"
#unless old_pid == server.pid
#  begin
#   sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
#   Process.kill :QUIT, File.read(old_pid).to_i
#   rescue Errno::ENOENT, Errno::ESRCH
#  end
#end
#end
#
#after_fork do |server, worker|
#    defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
#end

# coding:utf-8
# unicron.rb
worker_processes  4
working_directory '/home/ec2-user/rails-app/agrarian/'

listen '/home/ec2-user/rails-app/agrarian/tmp/unicorn.sock', :backlog => 1
listen 4423, :tcp_nopush => true

pid '/home/ec2-user/rails-app/agrarian/tmp/unicorn.pid'

timeout 10

stdout_path '/home/ec2-user/rails-app/agrarian/log/unicorn.stdout.log'
stderr_path '/home/ec2-user/rails-app/agrarian/log/unicorn.stderr.log'

preload_app  true
GC.respond_to?(:copy_on_write_friendly=) and GC.copy_on_write_friendly = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end

  sleep 1
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
