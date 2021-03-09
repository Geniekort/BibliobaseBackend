module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    # argument_class Types::BaseArgument
    # field_class Types::BaseField
    # input_object_class Types::BaseInputObject
    # object_class Types::BaseObject
    null false

    def render_resource(name, resource)
      if resource.errors.any?
        build_errors(resource)
        nil
      else
        {
          name => resource
        }
      end
    end

    # Map the errors of a resource to the API format
    def build_errors(resource)
      resource.errors.details.each do |attribute, errors|
        errors.each_with_index do |error_detail, error_index|
          attribute_name = error_detail[:field_name].present? ? error_detail[:field_name].camelcase(:lower) : attribute
          context.add_error(
            GraphQL::ExecutionError.new(
              resource.errors.messages[attribute][error_index],
              extensions: {
                attribute: attribute_name, 
                details: resource.errors.details[attribute][error_index]
              }
            )
          )
        end
      end
    end

    def ready?(**_args)
      # raise NotAuthorizedException unless skip_authorization || context[:current_user]

      true
    end

    def current_organization
      context[:organization]
    end

    def skip_authorization
      false
    end
  end
end
