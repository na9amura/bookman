import Query from './GoogleBooksQuery'
import Book from '../../models/books/Google'

export default class {

  constructor() { }

  find(title, author, isbn) {
    const query = new Query(title, author, isbn)

    return axios.get(`https://www.googleapis.com/books/v1/volumes?q=${ query.to_params() }`)
      .then((res) => {
        let items = res.data.items;
        return items.map(this._formatResult)
      })
      .catch((e) => {
        console.log(e);
        let mockResults = []
        for(let i = 0; i < 10; i++) {
          mockResults.push(
            {
              volumeInfo: {
                title: i,
                authors: ['anonymous author'],
                publisher: 'foobar enterprise',
                industryIdentifiers: [{ identifier: '123456789678' }],
                imageLinks: { thumbnail: 'http://localhost:9292/lgtm_go.png' },
              }
            }
          )
        }
        return mockResults.map(this._formatResult)
      })
  }

  _formatResult(result) {
    console.log(new Book(result))
    return new Book(result)
  }
}
