class CreatePlans < ActiveRecord::Migration[8.1]
  def change
    create_table :plans, id: :uuid do |t|
      t.references :workspace,
                   null: false,
                   foreign_key: true,
                   type: :uuid

      t.string :title, null: false
      t.text :description

      t.string :status,
               null: false,
               default: "draft"

      t.date :starts_on
      t.date :ends_on

      t.jsonb :settings,
              null: false,
              default: {}

      t.datetime :archived_at

      t.timestamps
    end

    add_index :plans, :status
    add_index :plans, :archived_at
  end
end
