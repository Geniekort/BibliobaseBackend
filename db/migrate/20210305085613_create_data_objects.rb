class CreateDataObjects < ActiveRecord::Migration[6.1]
  def change
    create_table :data_data_objects do |t|
      t.jsonb :data, default: {}
      t.references :data_type, null: false, foreign_key: {to_table: :data_data_types}
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
