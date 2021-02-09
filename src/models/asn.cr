class Asn < FREEGEOLITEIP::ApplicationRecord
  with_timestamps

  mapping(
    id: Primary32,
    system_number: Int32,
    system_organization: String,
    created_at: Time?,
    updated_at: Time?,
  )

  validates_uniqueness :system_number

  has_many :ips, Ip
end
