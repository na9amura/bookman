json.tag do
  json.merge! tag.attributes
  json.book do
    json.merge! tag.book.attributes
  end
end
