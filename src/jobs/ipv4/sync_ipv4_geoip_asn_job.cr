class FREEGEOLITEIP::Jobs::SyncIpv4GeoIpAsnJob < Mosquito::QueuedJob
  
  def perform
    db_data = IO::Memory.new

    # download database in tar.gz format
    HTTP::Client.get("https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-ASN&license_key=#{ENV["MAXMIND_LICENSE_KEY"]}&suffix=tar.gz") do |response|
      # confirm we got a successful response
      if response.status_code == 200
        # open tar.gz file
        Compress::Gzip::Reader.open(response.body_io) do |gzip|
          Crystar::Reader.open(gzip) do |tar|
            tar.each_entry do |entry|
              # find the .mmdb file
              if entry.name.includes?("GeoLite2-ASN.mmdb")
                # copy file content to IO for processing
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

    # parse mmdb file
    asn_data = MaxMindDB.open(db_data)

    # generate range of all possible ipv4 addresses
    if ENV["APP_ENV"] == "development"
      set_range = ["1.0.0.0", "1.0.0.5"]
    else
      set_range = ["1.0.0.0", "255.255.255.255"]
    end

    ranges = Helper::IP.create_range(set_range[0], set_range[1])

    ranges.each do |r|
      begin
        raw_data = asn_data.get(r.address)
        Jobs::Asns::ReadIpv4Job.new(raw_data, r.address).perform
      rescue exception
        pp exception
      end
    end

  end
end