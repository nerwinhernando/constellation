class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks, id: :uuid do |t|
      t.references :phase,
                   null: false,
                   foreign_key: true,
                   type: :uuid

      t.references :assignee,
                   foreign_key: { to_table: :users },
                   type: :uuid

      t.string :title, null: false
      t.text :description

      t.string :status,
               null: false,
               default: "todo"

      t.string :priority,
               null: false,
               default: "normal"

      t.integer :position,
                null: false,
                default: 0

      t.date :starts_on
      t.date :due_on
      t.datetime :completed_at

      t.jsonb :settings,
              null: false,
              default: {}

      t.timestamps
    end

    add_index :tasks, [:phase_id, :position]
    add_index :tasks, :status
    add_index :tasks, :priority
    add_index :tasks, :due_on
  end
end
