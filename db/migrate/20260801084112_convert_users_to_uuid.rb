class ConvertUsersToUuid < ActiveRecord::Migration[8.1]
  def up
    # 1. Add temporary UUID column
    add_column :users, :uuid_id, :uuid, default: -> { "gen_random_uuid()" }, null: false

    # 2. Drop the old primary key constraint (removes sequence dependency)
    execute "ALTER TABLE users DROP CONSTRAINT users_pkey CASCADE;"

    # 3. Drop the old integer ID column
    remove_column :users, :id

    # 4. Rename the UUID column to 'id'
    rename_column :users, :uuid_id, :id

    # 5. Make the new UUID column the primary key
    execute "ALTER TABLE users ADD PRIMARY KEY (id);"
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "Can't revert UUID primary key change automatically"
  end
end
