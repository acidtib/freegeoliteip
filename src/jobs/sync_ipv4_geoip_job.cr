class SyncIpv4GeoIpJob < Mosquito::PeriodicJob
  run_every 9000.seconds
  
  def perform
    pp "hello from mosquito"

    range = FREEGEOLITEIP::Helper::IP.create_range("0.0.0.0", "255.255.255.255")

    range.each do |i|
      pp i
    end
  end
end