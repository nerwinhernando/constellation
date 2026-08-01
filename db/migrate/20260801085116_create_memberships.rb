class CreateMemberships < ActiveRecord::Migration[8.1]
  def change
    create_table :memberships, id: :uuid do |t|
      t.references :workspace, null: false, foreign_key: { to_table: :workspaces }, type: :uuid
      t.references :user, null: false, foreign_key: { to_table: :users }, type: :uuid
      t.string :role, null: false, default: "member"
      t.datetime :joined_at

      t.timestamps
    end

    add_index :memberships,
              [ :workspace_id, :user_id ],
              unique: true
  end
end
