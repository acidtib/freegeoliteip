require "../config/main.cr"
require "../config/application.cr"

module FREEGEOLITEIP
  class Application < Grip::Application
    
    alias Controllers = FREEGEOLITEIP::Controllers

    def routes
      pipeline :api, [
        ValidIPPipe.new,
        CorsPipe.new,
        Pipes::PoweredByHeader.new
      ]

      scope "/" do
        pipe_through :api

        get "/", Controllers::Http::HomeController, as: :index
        
        get "/:ip", Controllers::Http::IPController, as: :index
        get "/:ip/country", Controllers::Http::IPController, as: :country
        get "/:ip/asn", Controllers::Http::IPController, as: :asn
      end
    end
  end
end

app = FREEGEOLITEIP::Application.new()
app.run