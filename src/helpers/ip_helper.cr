module FREEGEOLITEIP
  module Helper
    class IP
      def self.create_range(start_ip, end_ip)
        IPAddress::IPv4.new("1.255.255.254")..IPAddress::IPv4.new("2.0.1.0")
      end
    end
  end
end