require "jennifer"
require "jennifer/adapter/postgres"
require "maxminddb"
require "json"
require "ipaddress"
require "crystar"
require "compress/gzip"
require "http/client"

require "./version.cr"


require "./initializers/**"


require "../src/models/application_record"
require "../src/models/**"


require "../src/helpers/**"