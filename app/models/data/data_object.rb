class Data::DataObject < ApplicationRecord
  self.table_name = "data_data_objects"

  dynamic_model_data_object(data_type_class_name: "Data::DataType")

  belongs_to :project
end
