import Book from '../Book'

export default class extends Book {

  constructor(source) {
    super()
    const volumeInfo = source.volumeInfo
    this.volumeInfo = volumeInfo
    this.title          = _.get(volumeInfo, ['title'])
    this.author         = _.get(volumeInfo, ['authors', 0])
    this.publisher_name = _.get(volumeInfo, ['publisher'])
    this.isbn           = _.get(volumeInfo, ['industryIdentifiers', 0, 'identifier'])
    this.image_url      = _.get(volumeInfo, ['imageLinks', 'thumbnail'])
  }
}
