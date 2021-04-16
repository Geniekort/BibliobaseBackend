class CurationSession < ApplicationRecord
  belongs_to :data_type,
    class_name: "Data::DataType"
  belongs_to :project
  belongs_to :import
  belongs_to :started_by,
    class_name: "User"

  def curation_actions
    project.curation_actions.where("meta @> ?", {curation_session_id: id}.to_json)
  end
end
