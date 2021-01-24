require "mosquito"
require "../config/*"
require "./jobs/*"

Mosquito.configure do |settings|
  settings.redis_url = ENV["REDIS_JOBS_URL"]
end

# Mosquito::Redis.instance.flushall

Mosquito::Runner.start