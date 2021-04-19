module Audit
  module ActionDetailer
    extend ActiveSupport::Concern

    included do
      has_one :action,
              class_name: "Audit::Action",
              as: :action_detailer

      def self.create_with_action(detailer_params, action_params)
        detailer = create!(detailer_params)
        Action.create!(action_params.merge(action_detailer: detailer))
        detailer
      end
    end
  end
end
