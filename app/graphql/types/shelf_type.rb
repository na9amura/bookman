Types::ShelfType = GraphQL::ObjectType.define do
  name 'Shelf'

  field :id, !types.ID
  field :name, !types.String
  connection :books, Types::BookType.connection_type
end
