class CreateAuditResourceActions < ActiveRecord::Migration[6.1]
  def change
    create_table :audit_resource_actions do |t|
      t.string :type, index: true
      t.references :resource, polymorphic: true, index: true
      t.jsonb :old_attributes, default: {}
      t.jsonb :new_attributes, default: {}

      t.timestamps
    end
  end
end
