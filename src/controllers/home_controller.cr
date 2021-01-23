module FREEGEOLITEIP
  module Controllers
    class HomeController < Grip::Controllers::Http
      def index(context : Context)
        address = context.request.headers.get("X-Forwarded-For").to_s.split(",")[0].gsub("[\\", "")

        context
          .put_status(200)
          .json(
            {
              "ip" => address
            }
          )
      end
    end
  end
end