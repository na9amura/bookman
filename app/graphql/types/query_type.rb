Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :book do
    type !Types::BookType
    argument :id, !types.ID
    description 'Find a book by ID'
    resolve -> (obj, args, ctx) {
      Book.find(args['id'])
    }
  end

  field :shelf do
    type !Types::ShelfType
    argument :id, !types.ID
    description 'Find a shelf by ID'
    resolve -> (obj, args, ctx) {
      Shelf.find(args['id'])
    }
  end
end
