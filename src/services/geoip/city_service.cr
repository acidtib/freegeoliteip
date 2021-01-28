module FREEGEOLITEIP
  module Service
    module GeoIP
      class City
        property response
  
        def initialize(ip : String)
          @ip = ip
          @city = GeoIP2.open("./temp_db/GeoLite2-City.mmdb", ["en"])
          @response = Hash(
            String, (String | Float64 | Int32 | Nil) |
            NamedTuple(continent: NamedTuple(code: String | Nil, name: String | Nil), country: NamedTuple(code: String | Nil, name: String | Nil), region: NamedTuple(code: String | Nil, name: String | Nil), city: String | Nil, zip_code: String | Nil, latitude: Float64 | Nil, longitude: Float64 | Nil)
          ).new
          
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
          unless result.subdivisions.empty?
            region_code = result.subdivisions[0].iso_code
            region_name = result.subdivisions[0].name
          else
            region_code = nil
            region_name = nil
          end

          @response["location"] = {
            continent: {
              code: result.continent.code,
              name: result.continent.name
            },
            country: {
              code: result.country.iso_code,
              name: result.country.name
            },
            region: {
              code: region_code,
              name: region_name
            },
            city: result.city.name,
            zip_code: result.postal.code,
            latitude: result.location.latitude,
            longitude: result.location.longitude
          }

  
          @response["time_zone"] = result.location.time_zone
          @response["metro_code"] = result.location.metro_code
        end

        def to_json
          @response.to_json
        end
      end
    end
  end
end