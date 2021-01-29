module FREEGEOLITEIP
  module Helper
    class IP

      # FREEGEOLITEIP::Helper::IP.create_range("1.255.255.254", "2.0.1.0")
      def self.create_range(start_ip, end_ip)
        IPAddress::IPv4.new(start_ip)..IPAddress::IPv4.new(end_ip)
      end

    end
  end
end