module Types::Object::ImportField
  class Meta < Types::BaseObject
    description "Meta field of the import"

    field :format, String, null: false
    field :headers, Boolean, null: true
    field :column_separator, String, null: false
  end
end
