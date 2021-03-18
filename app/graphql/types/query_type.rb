module Types
  class QueryType < Types::BaseObject
    include Types::Query::Projects
    include Types::Query::Imports
    include Types::Query::DataTypes
    include Types::Query::DataObjects

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    description "The query root of this schema"
  end
end
