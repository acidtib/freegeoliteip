class FREEGEOLITEIP::Jobs::Asns::ReadIpv4Job < Mosquito::QueuedJob
  params(raw : MaxMindDB::Any, ip : String)

  def perform
    ip = ip?
    data = raw?.as(MaxMindDB::Any)

    unless data.empty?
      find_asn = Asn.where { _system_number == data["autonomous_system_number"].as_i }.first

      unless find_asn
        find_asn = Asn.create({ system_number: data["autonomous_system_number"].as_i, system_organization: data["autonomous_system_organization"].as_s })
      end

      check_ip = Ip.where { _address == ip }.first

      if check_ip
        check_ip.update(asn_id: find_asn.id)
      else
        Ip.create({ asn_id: find_asn.id, address: ip, address_type: "IPv4" })
      end

      pp ip
      pp "------------------"  
    end
  end

  def deserialize_max_mind_db__any(data)
    
  end

end