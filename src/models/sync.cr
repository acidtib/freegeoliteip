class Sync < FREEGEOLITEIP::ApplicationRecord
  with_timestamps

  mapping(
    id: Primary32,
    date: String,
    file_name: String,
    created_at: Time?,
    updated_at: Time?,
  )
end
