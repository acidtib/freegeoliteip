module FREEGEOLITEIP
  module Service
    module GeoIP
      class Asn
        property response
  
        def initialize(ip : String)
          @ip = ip
          @asn = GeoIP2.open("./temp_db/GeoLite2-ASN.mmdb", ["en"])
          @response = Hash(String, (String | Float64 | Int32 | Nil)).new
          
          @response["ip"] = @ip

          find()
        end
  
        def find
          begin
            data = @asn.asn(@ip)
            response(data)  
          rescue exception : GeoIP2::AddressNotFoundError
            @response["error"] = exception.message
          end
  
          @response
        end

        def response(result)
          @response["autonomous_system_number"] = result.autonomous_system_number
          @response["autonomous_system_organization"] = result.autonomous_system_organization
        end

        def to_json
          @response.to_json
        end
      end
    end
  end
end