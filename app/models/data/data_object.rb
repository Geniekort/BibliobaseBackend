class Data::DataObject < ApplicationRecord
  dynamic_model_data_object(data_type_class_name: "Data::DataType")

  belongs_to :project
end
