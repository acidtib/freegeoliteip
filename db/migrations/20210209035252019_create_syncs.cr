class CreateSyncs < Jennifer::Migration::Base
  def up
    create_table :syncs do |t|
      t.string :date, { :null => false }
      t.string :file_name, { :null => false }

      t.timestamps
    end
  end

  def down
    drop_table :syncs if table_exists? :syncs
  end
end
