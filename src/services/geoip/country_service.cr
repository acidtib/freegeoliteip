module FREEGEOLITEIP
  module Service
    module GeoIP
      class Country
        property response
  
        def initialize(ip : String)
          @ip = ip
          @country = GeoIP2.open("./temp_db/GeoLite2-Country.mmdb", ["en"])
          @response = Hash(String, (String | Float64 | Int32 | Nil)).new
          
          @response["ip"] = @ip

          find()
        end
  
        def find
          begin
            data = @country.country(@ip)
            response(data)  
          rescue exception : GeoIP2::AddressNotFoundError
            @response["error"] = exception.message
          end
  
          @response
        end

        def response(result)
          @response["country_code"] = result.country.iso_code
          @response["country_name"] = result.country.name
          @response["continent_code"] = result.continent.code
          @response["continent_name"] = result.continent.name
        end

        def to_json
          @response.to_json
        end
      end
    end
  end
end