require "mosquito"

Mosquito.configure do |settings|
  settings.redis_url = ENV["REDIS_JOBS_URL"]
end