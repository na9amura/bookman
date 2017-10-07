json.merge! book.attributes
json.image_url book.image_url
json.checking_out do
  if book.checking_out.present?
    json.merge! book.checking_out.attributes
    json.user book.checking_out&.user
  end
end
json.tags do
  json.merge! book.tags
end
json.shelf book.shelf
json.url book_url(book, format: :json)
