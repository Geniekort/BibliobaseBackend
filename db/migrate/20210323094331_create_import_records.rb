class CreateImportRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :import_records do |t|
      t.references :import, null: false, foreign_key: true
      t.jsonb :data

      t.timestamps
    end
  end
end
