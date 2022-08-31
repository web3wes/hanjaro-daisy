<template>
  <div class="login">
    <form @submit.prevent="attemptLogin()">
      <InputField
        v-model:value="form.Hangul_search.value"
        :errors="form.Hangul_search.errors"
        type="text"
        data-cy="word_search"
        label="Enter hangul:"
        placeholder="Enter Hangul"
      />

      <div>{{ doneTodosCount }}</div>

      <button data-cy="submit" type="submit">Login</button>
    </form>
  </div>
</template>

<script>
import { ref } from 'vue'
import { useStore } from 'vuex'
import { useRouter } from 'vue-router'
import { HomeForm } from '@/services/query'
import InputField from '@/components/inputs/InputField'
import Queries from '../services/query'

export default {
  name: 'Login',
  components: {
    InputField,
  },

  data() {
    return {
      words: 'dad',
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

    async function handleLoginSuccess(user) {
      await store.dispatch('setUser', user)
      const redirectPath = router.currentRoute.value.query.redirect
      if (redirectPath) {
        router.push({ path: redirectPath })
      } else {
        router.push({ name: 'Dashboard' })
      }
    }

    function handleLoginFailure(error) {
      alert(error)
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
    }
  },
}
</script>

<style scoped lang="scss"></style>
