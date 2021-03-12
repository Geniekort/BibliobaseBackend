class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # Create a service of a certain type for an instance of a model.
  def service(type, params = {})
    service_class_name = "Service::#{model_name.name}::#{type.to_s.camelcase}"
    service_class = service_class_name.safe_constantize

    raise ArgumentError, "Could not find class `#{service_class_name}`" unless service_class

    service_class.new(self, params)
  end
end
