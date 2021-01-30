class FREEGEOLITEIP::SyncIpv4GeoIpJob < Mosquito::PeriodicJob
  run_every 9000.seconds
  
  def perform
    # generate range of all possible ipv4 addresses
    if ENV["APP_ENV"] == "development"
      ranges = [
        ["0.0.0.0", "0.0.1.0"],
        ["0.0.1.1", "0.0.2.0"]
      ]
    else
      ranges = [
        ["0.0.0.0", "11.0.0.0"],
        ["11.0.0.1", "22.0.0.0"],
        ["22.0.0.1", "33.0.0.0"]
      ]
    end

    ranges.each do |range|
      set_range = Helper::IP.create_range(range[0], range[1])

      set_range.each do |i|
        ReadIpv4Job.new(i.address).perform
      end
    end
  end
end