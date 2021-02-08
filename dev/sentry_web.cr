require "sentry"

sentry = Sentry::ProcessRunner.new(
  display_name: "web_service",
  build_command: "crystal build --progress --define logs ./src/application.cr -o bin/freegeoliteip",
  run_command: "./bin/freegeoliteip",
  files: [
    "./config/**/*.cr", 
    "./src/application.cr", 
    "./src/controllers/**/*.cr", 
    "./src/models/**/*.cr", 
    "./src/helpers/**/*.cr", 
    "./src/services/**/*.cr",
    "./src/db/**"
  ]
)

sentry.run