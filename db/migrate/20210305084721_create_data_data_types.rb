class CreateDataDataTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :data_data_types do |t|
      t.jsonb :definition
      t.string :name
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
