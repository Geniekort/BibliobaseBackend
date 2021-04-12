class CreateAuditActions < ActiveRecord::Migration[6.1]
  def change
    create_table :audit_actions do |t|
      t.references :created_by, null: false, foreign_key: {to_table: :users}
      t.references :project, null: false
      t.string :type
      t.jsonb :meta, default: {}

      t.timestamps
    end

    add_index :audit_actions, %i[type]
    add_index :audit_actions, %i[meta]
  end
end
