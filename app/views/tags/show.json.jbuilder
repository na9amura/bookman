json.partial! 'tags/tag', tag: @tag_assign.tag
json.book do
  json.partial! 'books/book', book: @tag_assign.book
end
