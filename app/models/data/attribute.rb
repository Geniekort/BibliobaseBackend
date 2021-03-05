class Data::Attribute < ApplicationRecord
  dynamic_model_attribute(data_type_class_name: "Data::DataType")

  has_one :project, through: :data_type
end
