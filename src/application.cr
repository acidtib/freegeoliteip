require "../config/*"

module FREEGEOLITEIP
  class Application < Grip::Application
    alias Controllers = FREEGEOLITEIP::Controllers

    def routes
      pipeline :api, [
        Pipes::PoweredByHeader.new
      ]

      scope "/" do
        pipe_through :api

        get "/", Controllers::HomeController, as: :index
      end

    end
  end
end

app = FREEGEOLITEIP::Application.new()
app.run