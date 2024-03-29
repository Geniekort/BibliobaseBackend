class CurationSession < ApplicationRecord
  belongs_to :data_type,
    class_name: "Data::DataType"
  belongs_to :project
  belongs_to :import
  belongs_to :started_by,
    class_name: "User"

  has_many :curation_actions,
           class_name: "Audit::CurationAction"

  def curatable_records
    import.import_records
  end
end
