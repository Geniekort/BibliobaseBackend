module Service::Import
  class Parser < Base
    # Parse the `raw_data` into `parsed_data` using data provided in `meta`
    def perform
      if meta["format"] == "csv"
        record.service("parse/csv_parser").perform
        record.parsed = true
      elsif meta["format"] == "xml"
        record.service("parse/xml_parser").perform
        record.parsed = true
      else 
        record.errors.add(
          :meta,
          :unknown_format
        )
      end
    end

    def meta
      record.meta&.deep_stringify_keys || {}
    end
  end
end
