class CreateAsns < Jennifer::Migration::Base
  def up
    create_table :asns do |t|
      t.integer :system_number, { :null => false }
      t.string :system_organization, { :null => false }

      t.timestamps
    end
  end

  def down
    drop_table :asns if table_exists? :asns
  end
end
