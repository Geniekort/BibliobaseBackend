class CreateAuditResourceActions < ActiveRecord::Migration[6.1]
  def change
    create_table :audit_resource_actions do |t|
      t.string :type
      t.references :created_by, null: false, foreign_key: {to_table: :users}
      t.references :project, null: false
      t.bigint :resource_id
      t.string :resource_type
      t.jsonb :old_attributes, default: {}
      t.jsonb :new_attributes, default: {}
      t.jsonb :meta, default: {}

      t.timestamps
    end

    add_index :audit_resource_actions, %i[resource_type resource_id]
    add_index :audit_resource_actions, %i[type]
    add_index :audit_resource_actions, %i[meta]
  end
end
