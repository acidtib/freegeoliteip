require "grip"
require "geoip2"
require "json"
require "ipaddress"


require "../src/helpers/**"
require "../src/services/**"
require "../src/controllers/**"
require "../src/jobs/**"

module FREEGEOLITEIP

  GEOCITY = GeoIP2.open("./temp_db/GeoLite2-City.mmdb", ["en"])

end