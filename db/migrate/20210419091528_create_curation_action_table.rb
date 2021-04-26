class CreateCurationActionTable < ActiveRecord::Migration[6.1]
  def change
    create_table :audit_curation_actions do |t|
      t.string :curation_type, index: true
      t.references :curation_session, index: true
      t.references :created_data_object, index: true
      t.references :import_record, index: true
      t.timestamps
    end
  end
end
