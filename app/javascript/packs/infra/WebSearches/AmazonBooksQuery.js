export default class {

  constructor(title, author, isbn) {
    this.title = title
    this.author = author
    this.isbn = isbn
  }

  to_params() {
    let queries = this._assign_query_keys();
    return Object.keys(queries)
      .map(function(k) { return [k, this[k]] }, queries)
      .filter((e) => e[1])
      .map((e) => e[1])
      .join(' ');
  }

  _assign_query_keys() {
    return {
      intitle:  this.title,
      inauthor: this.author,
      isbn:     this.isbn,
    }
  }
}
