class CreateDataAttributes < ActiveRecord::Migration[6.1]
  def change
    create_table :data_attributes do |t|
      t.string :attribute_type
      t.string :name
      t.jsonb :definition
      t.jsonb :validation

      t.references :data_type, null: false, foreign_key: {to_table: :data_data_types}

      t.timestamps
    end
  end
end
