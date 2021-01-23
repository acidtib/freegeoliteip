module FREEGEOLITEIP
  module Controllers
    class HomeController < Grip::Controllers::Http
      def index(context : Context)
        forwarded = context.request.headers.get("X-Forwarded-For")
        puts forwarded
        address = forwarded[0].split(",")[0]

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