class CreateImports < ActiveRecord::Migration[6.1]
  def change
    create_table :imports do |t|
      t.string :name
      t.string :raw_data
      t.jsonb :meta
      t.jsonb :parsed_data
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
