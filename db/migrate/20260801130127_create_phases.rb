class CreatePhases < ActiveRecord::Migration[8.1]
  def change
    create_table :phases, id: :uuid do |t|
      t.references :plan,
                   null: false,
                   foreign_key: true,
                   type: :uuid

      t.string :title, null: false

      t.integer :position,
                null: false,
                default: 0

      t.boolean :collapsed,
                null: false,
                default: false

      t.timestamps
    end

    add_index :phases, [:plan_id, :position]
  end
end
