require 'redis'
if Rails.env == 'production'
  Redis.current = Redis.new(:host => ENV["REDIS_ENDPOINT"], :port => 6379)
else
  Redis.current = Redis.new(:host => '127.0.0.1', :port => 6379)
end
