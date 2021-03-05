class Data::DataType < ApplicationRecord
  self.table_name = "data_data_types"

  dynamic_model data_attribute_class_name: "Data::Attribute",
                data_object_class_name: "Data::DataObject"

  belongs_to :project
end
 