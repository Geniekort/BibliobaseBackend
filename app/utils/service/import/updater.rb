module Service::Import
  class Updater < Base
    def perform(persist: true)
      record.assign_attributes parsed_params[:input]
      record.service(:parser).perform if parsed_params[:parse_data]
      record.save if persist

      create_import_records if persist && parsed_params[:parse_data] && record.saved_change_to_parsed_data?
    end

    private

    # Create import records from the parsed data. Destroy existing import_records,
    #  in order to 'overwrite' them.
    def create_import_records
      record.import_records.destroy_all

      records_params = record.parsed_data.map do |record_data|
        { data: record_data }
      end

      record.import_records.insert_all(records_params)
    end

    # Parse input params to deal with special characters for example in meta.
    def parsed_params
      return @parsed_params if @parsed_params

      @parsed_params = params
      if @parsed_params.dig(:input, :meta, "columnSeparator")
        @parsed_params[:input][:meta]["columnSeparator"] =
          @parsed_params.dig(:input, :meta, "columnSeparator").gsub('\t', "\t")
      end

      @parsed_params
    end
  end
end
