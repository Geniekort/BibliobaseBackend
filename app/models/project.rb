class Project < ApplicationRecord
  has_many :data_types, class_name: "Data::DataType"
  has_many :data_objects, class_name: "Data::DataObject"
  has_many :imports
  has_many :curation_sessions
  has_many :curation_actions, class_name: "Audit::CurationAction"
end
