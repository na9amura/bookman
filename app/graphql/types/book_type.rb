Types::BookType = GraphQL::ObjectType.define do
  name 'Book'

  field :id, !types.ID
  field :title, !types.String
  field :author, !types.String
  field :isbn, !types.String
  field :shelf, Types::ShelfType
end
