module FREEGEOLITEIP
  module Controllers
    class HomeController < Grip::Controllers::Http
      def index(context : Context)
        puts context.request.headers.get?("X-Forwarded-For")
        puts context.request.inspect
        puts context.request.remote_address

        context
          .put_status(200)
          .json(
            {
              "id" => 1
            }
          )
      end
    end
  end
end