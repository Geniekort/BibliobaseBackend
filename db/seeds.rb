# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

p = Project.create(name: "Project Mater")


puts "Creating attributes for work_type"
work_type = p.data_types.create(name: "work", definition: {})

work_type.data_attributes.create(name: "title", attribute_type: "String").errors.inspect
work_type.data_attributes.create(name: "language", attribute_type: "String")
work_type.data_attributes.create(name: "date", attribute_type: "DateTime")

puts "Creating attributes for manifestation_type"
manifestation_type = p.data_types.create(name: "manifestation", definition: {})
manifestation_type.data_attributes.create(name: "title", attribute_type: "String")
manifestation_type.data_attributes.create(name: "date", attribute_type: "DateTime")
manifestation_type.data_attributes.create(name: "document_type", attribute_type: "String")
manifestation_type.data_attributes.create(name: "language", attribute_type: "String")
manifestation_type.data_attributes.create(name: "multivolume_part", attribute_type: "Number")

puts "Creating attributes for item_type"
item_type = p.data_types.create(name: "item", definition: {})
item_type.data_attributes.create(name: "title", attribute_type: "String")
item_type.data_attributes.create(name: "date", attribute_type: "DateTime")

puts "Creating attributes for digitized_copy_type"
digitized_copy_type = p.data_types.create(name: "digitized_copy", definition: {})
digitized_copy_type.data_attributes.create(name: "title", attribute_type: "String")
digitized_copy_type.data_attributes.create(name: "format", attribute_type: "String")
digitized_copy_type.data_attributes.create(name: "url", attribute_type: "Url")
digitized_copy_type.data_attributes.create(name: "digitization_data", attribute_type: "DateTime")
