module FREEGEOLITEIP
  module Controllers
    module Http
      class HomeController < Grip::Controllers::Http
        def index(context : Context)
          forwarded = context.request.headers.get("X-Forwarded-For")
          puts forwarded
          
          address = forwarded[0].split(",")[0]

          response = Service::GeoIP::City.new(address)

          context
            .put_status(200)
            .json(response)
        end
      end
    end
  end
end