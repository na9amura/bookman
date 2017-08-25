let Books = {
  debug: true,
  state: {
    list: [],
    web_search: {
      results: [
        {
          selected: false,
          selectable: false,
          book: {}
        }
      ],
      query: '',
    },
    new_request: {}
  },
};

export default Books
