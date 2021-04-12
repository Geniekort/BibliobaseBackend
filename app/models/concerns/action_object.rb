module ActionObject
  extend ActiveSupport::Concern

  included do
    # Todo: Define parent actions
    # has_many :resource_actions,
    #          class_name: "Audit::ResourceAction",
    #          as: :resource
  end
end
