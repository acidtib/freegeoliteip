module FREEGEOLITEIP
  module Service
    module GeoIP
      class City
        # property response
  
        def initialize(ip : String)
          @ip = ip
          @city = GeoIP2.open("./temp_db/GeoLite2-City.mmdb", ["en"])
          @response = GeoIP2::Model::City.new(@city, ["en"], ip)
          find()
        end
  
        def find
          @response = @city.city(@ip)
        end
  
        # def response(result)
        #   unless result.subdivisions.empty?
        #     region_code = result.subdivisions[0].iso_code
        #     region_name = result.subdivisions[0].name
        #   else
        #     region_code = nil
        #     region_name = nil
        #   end

        #   @response["location"] = {
        #     continent: {
        #       code: result.continent.code,
        #       name: result.continent.name
        #     },
        #     country: {
        #       code: result.country.iso_code,
        #       name: result.country.name
        #     },
        #     region: {
        #       code: region_code,
        #       name: region_name
        #     },
        #     city: result.city.name,
        #     zip_code: result.postal.code,
        #     latitude: result.location.latitude,
        #     longitude: result.location.longitude
        #   }

  
        #   @response["time_zone"] = result.location.time_zone
        #   @response["metro_code"] = result.location.metro_code
        # end

        def to_json
          @response.to_json
        end
      end
    end
  end
end