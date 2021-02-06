class FREEGEOLITEIP::Jobs::CheckGeoipDbJob < Mosquito::PeriodicJob
  run_every 7200.minutes
  
  def perform
    # check for updated database
    
    Jobs::SyncIpv4GeoIpAsnJob.new().perform
  end
end