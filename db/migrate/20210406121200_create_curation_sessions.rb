class CreateCurationSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :curation_sessions do |t|
      t.references :project, null: false
      t.references :data_type, null: false, foreign_key: {to_table: :data_data_types}
      t.references :import, null: false, foreign_key: true
      t.references :started_by, null: false, foreign_key: {to_table: :users}
      t.jsonb :mapping, null: false, default: {}
      t.timestamps
    end
  end
end
