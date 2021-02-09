module FREEGEOLITEIP
  module Controllers
    module Http
      class HomeController < Grip::Controllers::Http
        def index(context : Context)
          forwarded = context.request.headers.get("X-Forwarded-For")
          
          ip_address = forwarded[0].split(",")[0]
          ip_address = "1.0.0.5" if ENV["APP_ENV"] == "development"
          
          response = Views::Base.result(ip_address)

          context
            .put_status(200)
            .json(response)
        end
      end
    end
  end
end