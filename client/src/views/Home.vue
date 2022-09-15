<template>
  <div class="login">
    <div class="grid grid-cols-5 gap-3">
      <div>
        <form @submit.prevent="attemptLogin()">
          <InputField
            v-model:value="form.Hangul_search.value"
            :errors="form.Hangul_search.errors"
            type="text"
            data-cy="word_search"
            placeholder="Enter Hangul"
          />
        </form>
        <div class="grid grid-cols-4 gap-3">
          <div class="col-span-2 bg-blue-600" @click="attemptLogin()">
            <button data-cy="submit" type="submit">Search</button>
          </div>
          <div class="col-span-2 bg-blue-600">
            <button data-cy="submit" type="submit" @click="test(form.Hangul_search.value)">
              Save
            </button>
          </div>
        </div>
      </div>
      <div class="col-span-4">
        <div class="overflow-x-auto">
          <table class="table w-full table-zebra mt-10">
            <thead>
              <tr>
                <th></th>
                <th>Word</th>
                <th>Definition</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <th>1</th>
                <td>{{ doneTodosCount[0] }}</td>
                <td></td>
                <td></td>
              </tr>
              <tr>
                <th>2</th>
                <td>{{ doneTodosCount[1] }}</td>
                <td></td>
                <td></td>
              </tr>
              <tr>
                <th>3</th>
                <td></td>
                <td></td>
                <td></td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref } from 'vue'
import { useStore } from 'vuex'
import { useRouter } from 'vue-router'
import { HomeForm } from '@/services/query'
import InputField from '@/components/inputs/InputField'
import Queries from '../services/query'

const people = [
  {
    name: 'Calvin Hawkins',
    email: 'calvin.hawkins@example.com',
    image:
      'https://images.unsplash.com/photo-1491528323818-fdd1faba62cc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80',
  },
  {
    name: 'Kristen Ramos',
    email: 'kristen.ramos@example.com',
    image:
      'https://images.unsplash.com/photo-1550525811-e5869dd03032?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80',
  },
  {
    name: 'Ted Fox',
    email: 'ted.fox@example.com',
    image:
      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80',
  },
]

export default {
  name: 'Login',
  components: {
    InputField,
  },

  data() {
    return {
      words: 'dad',
      saveWords: 'savedWords',
    }
  },

  computed: {
    doneTodosCount() {
      console.log('??')
      return this.$store.getters.words
    },
  },

  setup() {
    const store = useStore()
    const router = useRouter()
    const form = ref(new HomeForm())

    async function test() {
      // const unwrappedForm = form.value
      console.log('saving ' + store.getters.words)
      this.saveWords = await Queries.api.savedWord({ saveWord: store.getters.words })
    }

    async function attemptLogin() {
      // unwrap form

      console.log('connect')
      const unwrappedForm = form.value
      console.log(store.state)

      this.words = await Queries.api.loginNot({ word: unwrappedForm.Hangul_search.value })

      // store.commit({
      //   type: 'setWords',
      //   value: this.orgSize,
      // })
      store.dispatch('currentWords', this.words)
      console.log(store?.state?.words)
      // .then(handleLoginSuccess)
      // .catch(handleLoginFailure)
    }

    // this.words = store?.state

    return {
      form,
      attemptLogin,
      people,
      test,
    }
  },
}
</script>

<style scoped lang="scss"></style>
