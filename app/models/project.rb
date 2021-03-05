class Project < ApplicationRecord
  has_many :data_types, class_name: "Data::DataType"
  has_many :data_objects, class_name: "Data::DataObject"
end
