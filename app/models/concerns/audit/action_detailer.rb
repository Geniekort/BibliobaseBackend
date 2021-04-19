module Audit
  module ActionDetailer
    extend ActiveSupport::Concern

    included do
      has_one :action,
              class_name: "Audit::Action",
              as: :action_detailer
    end
  end
end
