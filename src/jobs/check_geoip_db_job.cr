class FREEGEOLITEIP::Jobs::CheckGeoipDbJob < Mosquito::PeriodicJob
  run_every 7200.minutes
  
  def perform
    # check for updated database
    
  end
end