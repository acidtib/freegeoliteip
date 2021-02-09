Jennifer::Config.from_uri(ENV["DATABASE_URI"])

Jennifer::Config.configure do |conf|
  conf.adapter = "postgres"
  conf.logger.level = :debug
end