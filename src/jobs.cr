require "../config/main.cr"
require "../config/jobs.cr"


require "./jobs/**"

# Mosquito::Redis.instance.flushall

Mosquito::Runner.start