class SyncIpv4GeoIpJob < Mosquito::PeriodicJob
  run_every 55.seconds
  
  def perform
    pp "hello from mosquito"
  end
end