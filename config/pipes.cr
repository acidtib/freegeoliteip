module FREEGEOLITEIP
  class ValidIPPipe < Pipes::Base
    def call(context : HTTP::Server::Context) : HTTP::Server::Context
      # skip check if home is being requested
      return context if context.request.resource == "/"

      begin
        source_ip = context.request.resource.split("/")[1]
        ip_valid = IPAddress.valid?(source_ip)

        raise("Invalid IP address: #{source_ip}") if ip_valid == false

        context
      rescue exception        
        context
          .put_status(400)
          .json(
            {
              "error" => exception.message
            }
          )
          .halt
      end
    end
  end

  class CorsPipe < Pipes::Base
    def call(context : HTTP::Server::Context) : HTTP::Server::Context
      context.response.headers["Access-Control-Allow-Origin"] = "*"
      context.response.headers["Access-Control-Allow-Methods"] = "POST, GET, OPTIONS"
      context
    end
  end
end