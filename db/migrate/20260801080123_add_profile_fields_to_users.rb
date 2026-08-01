class AddProfileFieldsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :username, :string
    add_column :users, :name, :string
    add_column :users, :timezone, :string
    add_column :users, :locale, :string
    add_column :users, :avatar_url, :string
    add_column :users, :onboarding_completed_at, :datetime
    add_column :users, :last_seen_at, :datetime

    add_index :users, :username, unique: true
  end
end
