module FREEGEOLITEIP
  class ValidIPPipe < Pipes::Base
    def call(context : HTTP::Server::Context) : HTTP::Server::Context
      # Mutate the context and pass it on to the next handler.

      begin
        source_ip = context.request.resource.gsub("/", "")
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
end