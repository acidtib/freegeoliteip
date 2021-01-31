class FREEGEOLITEIP::Jobs::SyncIpv4GeoIpCity < Mosquito::PeriodicJob
  run_every 7200.minutes
  
  def perform
    db_data = IO::Memory.new

    HTTP::Client.get("https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-City&license_key=#{ENV["MAXMIND_LICENSE_KEY"]}&suffix=tar.gz") do |response|
      pp response.status_code 
      if response.status_code == 200
        Compress::Gzip::Reader.open(response.body_io) do |gzip|
          Crystar::Reader.open(gzip) do |tar|
            tar.each_entry do |entry|
              if entry.name.includes?("GeoLite2-City.mmdb")
                pp entry.name
                IO.copy entry.io, db_data
                break
              end
            end
          end
        end
      else
        return
      end
    end

    city_data = MaxMindDB.open(db_data)

    # generate range of all possible ipv4 addresses
    if ENV["APP_ENV"] == "development"
      set_range = ["1.0.0.0", "1.1.60.188"]
    else
      set_range = ["1.0.0.0", "1.0.0.10"]
    end

    ranges = Helper::IP.create_range(set_range[0], set_range[1])

    ranges.each do |r|
      begin
        raw_data = city_data.get(r.address)
        # ReadIpv4AsnJob.new(raw_data, r.address).perform
      rescue exception
        pp exception
      end
    end

  end
end