json.merge! book.attributes
json.checking_out do
  if book.checking_out.present?
    json.merge! book.checking_out.attributes
    json.user book.checking_out&.user
  end
end
json.url book_url(book, format: :json)
