module FREEGEOLITEIP
  module Service
    module GeoIP
      class City
        property response
  
        def initialize(ip : String)
          @ip = ip
          @city = GeoIP2.open("./temp_db/GeoLite2-City.mmdb", ["en"])
          @response = Hash(String, (String | Float64 | Int32 | Nil)).new
          
          @response["ip"] = @ip

          find()
        end
  
        def find
          begin
            data = @city.city(@ip)
            response(data)  
          rescue exception : GeoIP2::AddressNotFoundError
            @response["error"] = exception.message
          end
  
          @response
        end
  
        def response(result)
          @response["city"] = result.city.name
          @response["zip_code"] = result.postal.code
  
          unless result.subdivisions.empty?
            @response["region_code"] = result.subdivisions[0].iso_code
            @response["region_name"] = result.subdivisions[0].name
          else
            @response["region_code"] = nil
            @response["region_name"] = nil
          end
  
          @response["country_code"] = result.country.iso_code
          @response["country_name"] = result.country.name
          @response["latitude"] = result.location.latitude
          @response["longitude"] = result.location.longitude
          @response["metro_code"] = result.location.metro_code
          @response["time_zone"] = result.location.time_zone
        end

        def to_json
          @response.to_json
        end
      end
    end
  end
end