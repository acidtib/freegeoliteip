class CreateIps < Jennifer::Migration::Base
  def up
    create_table :ips do |t|
      t.string :address, { :null => false }
      t.string :address_type, { :null => false }

      t.reference :asn

      t.timestamps
    end
  end

  def down
    drop_foreign_key :ips, :asn if foreign_key_exists? :ips, :asn
    drop_table :ips if table_exists? :ips
  end
end
