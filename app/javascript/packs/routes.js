export default [
  {
    path: '/',
    component: require('./pages/Books')
  },
  {
    path: '/book/:id',
    component: require('./pages/Book')
  }
]
