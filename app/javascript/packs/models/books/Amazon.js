import Book from '../Book'

export default class extends Book {

  constructor(source) {
    super()
    this.item = source
    this.title          = _.get(source, ['ItemAttributes', 'Title'])
    this.author         = _.get(source, ['ItemAttributes', 'Author'])
    this.publisher_name = _.get(source, ['ItemAttributes', 'Publisher'])
    this.isbn           = _.get(source, ['ItemAttributes', 'ISBN'])
    this.image_url      = _.get(source, ['SmallImage', 'URL'])
  }
}
