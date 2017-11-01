import Query from './AmazonBooksQuery'
import Book from '../../models/Book'

export default class {

  constructor() { }

  find(title, author, isbn) {
    const query = new Query(title, author, isbn)

    return axios.get(`/amazon_books_api/?q=${ query.to_params() }`)
      .then((res) => {
        let items = res.data.Items.Item
        return items.map(this._formatResult)
      })
      .catch((e) => {
        let mockResults = []
        for(let i = 0; i < 10; i++) {
          mockResults.push({
            title: i,
            author: 'fizz bazz',
            publisher_name: 'foobar enterprise',
            isbn: '123456789678',
            image_url: 'http://localhost:9292/lgtm_go.png',
          })
          return mockResults
        }
      })
  }

  _formatResult(result) {
    return new Book({
      title: result.ItemAttributes.Title,
      author: result.ItemAttributes.Author[0],
      publisher_name: result.ItemAttributes.Publisher,
      isbn: result.ItemAttributes.ISBN,
      image_url: result.SmallImage.URL,
    })
  }
}
