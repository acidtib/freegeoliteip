require "grip"
require "maxminddb"
require "geoip2"
require "json"
require "ipaddress"
require "crystar"
require "compress/gzip"
require "http/client"


require "../src/helpers/**"
require "../src/services/**"
require "../src/controllers/**"
require "../src/jobs/**"

module FREEGEOLITEIP

  GEOCITY = GeoIP2.open("./temp_db/GeoLite2-City.mmdb", ["en"])

end