import Query from './GoogleBooksQuery'

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
    return {
      title: result.volumeInfo.title,
      author: result.volumeInfo.authors[0],
      publisher_name: result.volumeInfo.publisher,
      isbn: result.volumeInfo.industryIdentifiers[0].identifier,
      image_url: _.get(result, ['volumeInfo', 'imageLinks', 'thumbnail']),
    };
  }
}
