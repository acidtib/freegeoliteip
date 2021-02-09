class FREEGEOLITEIP::Jobs::CheckGeoipDbJob < Mosquito::PeriodicJob
  run_every 1440.minutes # 24 hours
  
  def perform

    # check for asn update database
    HTTP::Client.get("https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-ASN&license_key=#{ENV["MAXMIND_LICENSE_KEY"]}&suffix=tar.gz") do |response|
      if response.status_code == 200
        # "attachment; filename=GeoLite2-ASN_20210209.tar.gz"
        file_name = response.headers["Content-Disposition"].gsub("attachment; filename=", "")
        now = Time.local.to_s("%Y%m%d")

        # dont double sync the same database
        check_sync = Sync.where {_file_name == file_name}.first
        if check_sync
          return
        else
          Sync.create({date: now, file_name: file_name})
        end

        last_modified = file_name.gsub(".tar.gz", "").split("_").last

        if now.to_i >= last_modified.to_i
          Jobs::SyncIpv4GeoIpAsnJob.new().perform
        end
      end
    end
    
  end
end