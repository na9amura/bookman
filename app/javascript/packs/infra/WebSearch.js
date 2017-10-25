export default class {

  constructor(apiDriver) {
      this.apiDriver = apiDriver
  }

  find(title, author, isbn) {
    return this.apiDriver.find(title, author, isbn)
  }
}
