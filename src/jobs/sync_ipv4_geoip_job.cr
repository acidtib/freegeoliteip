class SyncIpv4GeoIpJob < Mosquito::PeriodicJob
  run_every 9000.seconds
  
  def perform
    pp "hello from mosquito"

    if ENV["APP_ENV"] == "development"
      range = FREEGEOLITEIP::Helper::IP.create_range("1.255.255.254", "2.0.1.0")
    else
      # generate range of all possible ipv4 addresses
      range = FREEGEOLITEIP::Helper::IP.create_range("0.0.0.0", "255.255.255.255")  
    end

    range.each do |i|
      address = i.address

      puts address
    end
  end
end