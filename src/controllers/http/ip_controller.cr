module FREEGEOLITEIP
  module Controllers
    module Http
      class IPController < Grip::Controllers::Http
        def index(context : Context)
          address = context.fetch_path_params.["ip"]

          response = Service::GeoIP::City.new(address)

          context
            .put_status(200)
            .json(response)
        end
      end
    end
  end
end