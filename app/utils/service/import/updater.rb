module Service::Import
  class Updater < Base
    def perform
      record.assign_attributes parsed_params[:input]
      record.service(:parser).perform if parsed_params[:parse_data]
      record.save
    end

    private

    # Parse input params to deal with special characters for example in meta.
    def parsed_params
      return @parsed_params if @parsed_params

      @parsed_params = params
      if @parsed_params.dig(:input, :meta, "columnSeparator")
        @parsed_params[:input][:meta]["columnSeparator"] = @parsed_params.dig(:input, :meta, "columnSeparator").gsub('\t', "\t")
      end

      @parsed_params
    end
  end
end
