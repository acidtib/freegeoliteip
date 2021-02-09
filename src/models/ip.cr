class Ip < FREEGEOLITEIP::ApplicationRecord
  with_timestamps

  mapping(
    id: Primary32,
    address: String,
    address_type: String,
    asn_id: Int32?,
    created_at: Time?,
    updated_at: Time?,
  )

  belongs_to :asn, Asn

  validates_uniqueness :address
end
