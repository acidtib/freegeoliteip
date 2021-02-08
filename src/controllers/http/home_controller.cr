module FREEGEOLITEIP
  module Controllers
    module Http
      class HomeController < Grip::Controllers::Http
        def index(context : Context)
          forwarded = context.request.headers.get("X-Forwarded-For")
          
          ip_address = forwarded[0].split(",")[0]
          ip_address = "1.0.0.1" if ENV["APP_ENV"] == "development"
          
          get_ip = Ip.where { _address == ip_address }.includes(:asn).first!

          response = {
            ip: get_ip.address,
            type: get_ip.address_type,
            location: {
              continent: {
                code: "",
                name: ""
              },
              country: {
                code: "",
                name: ""
              },
              region: {
                code: "",
                name: ""
              },
              city: "",
              zip_code: "",
              latitude: "",
              longitude: ""
            },
            asn: {
              number: get_ip.asn!.system_number,
              organization: get_ip.asn!.system_organization
            }
          }

          context
            .put_status(200)
            .json(response)
        end
      end
    end
  end
end