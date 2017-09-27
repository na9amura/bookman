import Vue from 'vue'
import App from '../../App'

describe('App.test.js', () => {
  let cmp, vm

  beforeEach(() => {
    cmp = Vue.extend(App)
    vm = new cmp().$mount()
  })

  it('has the expected html struvture', () => {
    expect(vm.$el).toMatchSnapshot()
  })
})
