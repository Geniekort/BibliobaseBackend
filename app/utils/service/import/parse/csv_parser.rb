require "csv"

module Service::Import::Parse
  class CsvParser < Service::Base
    def perform
      record.parsed_data = process parsed_data
    end

    # If a csv has headers, than use these as keys for the parsed data objects.
    #  Otherwise, use stringified index numbers.
    def parsed_data
      if file_has_headers
        CSV.parse(raw_data, col_sep: column_separator, headers: true).map(&:to_h)
      else
        CSV.parse(raw_data, col_sep: column_separator).map do |row|
          row.map.with_index { |val, idx| [idx.to_s, val] }.to_h
        end
      end
    end

    # Remove all empty lines from parsed data
    def process(parsed_data)
      parsed_data.reject { |row| row.values.all?(&:nil?) }
    end

    def file_has_headers
      meta["headers"]
    end

    def column_separator
      sep = meta["column_separator"]
      !sep.empty? ? sep : ","
    end

    def raw_data
      record.raw_data
    end

    def meta
      {
        "headers" => false,
        "column_separator" => ","
      }.deep_merge(record.meta || {})
    end
  end
end
