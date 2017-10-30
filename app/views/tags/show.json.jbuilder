json.tag do
  json.partial! 'tags/tag', tag: @tag_assign.tag
end
json.book do
  json.partial! 'books/book', book: @tag_assign.book
end
