require "sentry"

sentry = Sentry::ProcessRunner.new(
  display_name: "job_service",
  build_command: "crystal build --progress ./src/jobs.cr -o bin/jobs",
  run_command: "./bin/jobs",
  files: [
    "./config/**/*.cr", 
    "./src/jobs.cr", 
    "./src/jobs/**/*.cr", 
    "./src/models/**/*.cr", 
    "./src/helpers/**/*.cr", 
    "./src/services/**/*.cr"
  ]
)

sentry.run