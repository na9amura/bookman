json.extract! book, :id, :title, :author, :isbn
json.url book_url(book, format: :json)
json.checking_out book.checking_out
