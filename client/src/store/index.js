import { createStore } from 'vuex'
import createPersistedState from 'vuex-persistedstate'
import { SET_USER, SET_WORDS } from './mutation-types'

const STORAGE_HASH = 'Ax4XDbqIDE'
export const STORAGE_KEY = `Hangullo-daisy${STORAGE_HASH}`

const state = {
  user: '',
  words: '',
}

const mutations = {
  [SET_USER]: (state, payload) => {
    state.user = payload
  },

  [SET_WORDS]: (state, payload) => {
    state.words = payload?.data
    console.log(payload)
  },
}

const actions = {
  setUser({ commit }, user) {
    commit(SET_USER, user)
  },
  currentWords({ commit }, payload) {
    commit(SET_WORDS, payload)
  },
}

const getters = {
  isLoggedIn: (state) => {
    return !!state.user
  },
  user: (state) => {
    return state.user
  },

  words: (state) => {
    return state.words
  },

  token: (state) => {
    return state.user ? state.user.token : null
  },
}

const store = createStore({
  state,
  mutations,
  actions,
  getters,
  modules: {},
  plugins: [
    createPersistedState({
      key: STORAGE_KEY,
    }),
  ],
})

export default store
