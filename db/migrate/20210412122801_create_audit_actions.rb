class CreateAuditActions < ActiveRecord::Migration[6.1]
  def change
    create_table :audit_actions do |t|
      t.references :project, null: false, index: true
      t.references :created_by, null: false, foreign_key: {to_table: :users}, index: true
      t.references :action_details, polymorphic: true, null: true, index: true
      t.string :type, index: true
      t.jsonb :meta, default: {}

      t.timestamps
    end
  end
end
