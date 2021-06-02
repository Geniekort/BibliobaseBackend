module Query::Node::Matcher
  # Represents a key:value pair in the original query string as part of a Matcher
  class MatcherEntry < Query::Node::Node
    attr_accessor :value, :referenced_data_types, :allowed_data_attribute_types, :allowed_value_types

    def initialize(node_key, value, context, allowed_data_attribute_types, allowed_value_types)
      super(node_key, context)
      @value = value
      @allowed_data_attribute_types = allowed_data_attribute_types
      @allowed_value_types = allowed_value_types
    end

    # Retrieve the value for this matcher entry from a data object.
    def retrieve_object_value(data_object)
      data_object.get_data_by_attribute(matching_data_attribute)
    end

    # Validation: 
    #  - Validate whether the node_key corresponds with some data_attribute of the queried_data_type
    def validate
      unless matching_data_attribute.present? 
        errors.add(:node_key, :invalid_attribute_name, matched_data_attribute_name: node_key)
        return false
      end

      unless allowed_data_attribute_types.include? matching_data_attribute.attribute_type
        errors.add(:node_key, :invalid_matching_data_attribute_type, matched_data_attribute_name: node_key)
        return false
      end

      unless allowed_value_types.include?(value.class.to_s)
        errors.add(:value, :invalid_type, matched_data_attribute_name: node_key)
        return false
      end

      super
    end

    # The data attribute which corresponds to the node_key of this matchter entry
    # TODO: retrieve "referenced attributes" here as well, incase node_key is like: `author.first_name`
    def matching_data_attribute
      return @matching_data_attribute if @matching_data_attribute

      @matching_data_attribute = context.queried_data_type.data_attributes.detect do |attribute|
        attribute.name == node_key
      end
    end
  end
end
