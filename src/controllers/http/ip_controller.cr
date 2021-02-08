module FREEGEOLITEIP
  module Controllers
    module Http
      class IPController < Grip::Controllers::Http
        def index(context : Context)
          address = context.fetch_path_params.["ip"]

          # response = GEOCITY.city(address)

          response = {jsjsL: "sss"}

          context
            .put_status(200)
            .json(response)
        end

        def country(context : Context)
          address = context.fetch_path_params.["ip"]
          
          # response = Service::GeoIP::Country.new(address)
          response = {jsjsL: "sss"}

          context
            .put_status(200)
            .json(response)
        end

        def asn(context : Context)
          address = context.fetch_path_params.["ip"]
          
          # response = Service::GeoIP::Asn.new(address)
          response = {jsjsL: "sss"}

          context
            .put_status(200)
            .json(response)
        end
      end
    end
  end
end