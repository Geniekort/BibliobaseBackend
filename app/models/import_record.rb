class ImportRecord < ApplicationRecord
  belongs_to :import

  class << self
    def insert_all(records)
      normalized = normalize(records)
      super(normalized)
    end

    def normalize(records)
      records.each do |rec|
        add_timestamp(rec)
      end
    end

    def add_timestamp(record)
      time = Time.now.utc

      record["created_at"] = time
      record["updated_at"] = time
    end
  end
end
