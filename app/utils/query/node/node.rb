module Query::Node
  class Node
    include ActiveModel::Validations

    attr_accessor :context, :node_key

    def initialize(node_key, context)
      @context = context
      @node_key = node_key
      @nested_errors_details = {}
    end

    # Validate whether this node was given correct information (query_hash, context and node key)
    def validate
      true
    end

    # Return validation errors of this object merged with all nested errors
    def full_errors_details
      errors.details.to_h.merge(@nested_errors_details)
    end

    def add_nested_errors(attribute, other_validator)
      @nested_errors_details[attribute] = other_validator.full_errors_details
    end
  end
end
