require "grip"

require "./pipes.cr"

# require "../src/services/**"
require "../src/controllers/**"


module FREEGEOLITEIP

  RES = Hash(
    String, String | 
    NamedTuple(number: Int32 | Nil, organization: String | Nil) |
    NamedTuple(
      continent: NamedTuple(code: String | Nil, name: String | Nil), 
      country: NamedTuple(code: String | Nil, name: String | Nil), 
      region: NamedTuple(code: String | Nil, name: String | Nil),
      city: String | Nil,
      zip_code: String | Nil,
      latitude: String | Nil,
      longitude: String | Nil
    )
  ).new(nil)
  

  module Views
    class Base
      def self.result(ip)
        response = RES

        response["ip"] = ip

        begin
          get_ip = Ip.where { _address == ip }.includes(:asn).first!

          response["type"] = get_ip.address_type

          response["location"] = {
            continent: {
              code: "",
              name: ""
            },
            country: {
              code: "",
              name: ""
            },
            region: {
              code: "",
              name: ""
            },
            city: "",
            zip_code: "",
            latitude: "",
            longitude: ""
          }

          response["asn"] = {
            number: get_ip.asn!.system_number,
            organization: get_ip.asn!.system_organization
          }
        rescue exception
          return empty(ip)
        end

        return response
      end

      def self.empty(ip)
        response = RES

        response["ip"] = ip
        response["type"] = ""

        response["location"] = {
          continent: {
            code: nil,
            name: nil
          },
          country: {
            code: nil,
            name: nil
          },
          region: {
            code: nil,
            name: nil
          },
          city: nil,
          zip_code: nil,
          latitude: nil,
          longitude: nil
        }

        response["asn"] = {
          number: nil,
          organization: nil
        }

        return response
      end

      def self.asn(ip)
        response = RES

        response["ip"] = ip

        begin
          get_ip = Ip.where { _address == ip }.includes(:asn).first!

          response["type"] = get_ip.address_type

          response["asn"] = {
            number: get_ip.asn!.system_number,
            organization: get_ip.asn!.system_organization
          }
        rescue exception
          response["type"] = ""
          response["asn"] = {
            number: nil,
            organization: nil
          }
        end

        return response
      end
    end
  end
end