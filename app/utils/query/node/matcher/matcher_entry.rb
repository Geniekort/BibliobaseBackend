module Query::Node::Matcher
  # Represents a key:value pair in the original query string as part of a Matcher
  class MatcherEntry < Query::Node::Node
    attr_accessor :value, :referenced_data_types

    # Retrieve the value for this matcher entry from a data object.
    def retrieve_object_value(data_object)
      data_object.get_data_by_attribute(matching_data_attribute)
    end

    def validate
      matching_data_attribute.present?
    end

    private

    # The data attribute which 
    def matching_data_attribute
      return @matching_data_attribute if @matching_data_attribute

      @matching_data_attribute = context.queried_data_type.data_attributes.detect do |attribute|
        attribute.name == node_key
      end
    end
  end
end
