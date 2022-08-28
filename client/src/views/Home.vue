<template>
  <form @submit.prevent="attemptLogin()">
    <InputField
      v-model:value="form.email.value"
      :errors="form.email.errors"
      @blur="form.email.validate()"
      type="email"
      data-cy="email"
      label="Email:"
      placeholder="Email"
    />

    <InputField
      v-model:value="form.password.value"
      :errors="form.password.errors"
      @blur="form.password.validate()"
      type="password"
      data-cy="password"
      label="Password:"
      placeholder="Password"
    />

    <button data-cy="submit" type="submit">Login</button>
  </form>
</template>

<script>
import { ref } from 'vue'
import axios from 'axios'
import cheerio from 'cheerio'
import Query, { LoginForm } from '@/services/queries/'

export default {
  data() {
    return {
      lastestArticles: [], // defined empty array variable
    }
  },
  name: 'App',
  created() {
    this.getWebsiteData()
  },
  setup() {
    const form = ref(new LoginForm())

    function attemptLogin() {
      // unwrap form
      const unwrappedForm = form.value
      unwrappedForm.validate()
      if (!unwrappedForm.isValid) return

      Query.api
        .login({ email: unwrappedForm.email.value, password: unwrappedForm.password.value })
        .then('handleLoginSuccess')
        .catch('handleLoginFailure')
    }

    return {
      form,
      attemptLogin,
    }
  },

  methods: {
    async getWebsiteData() {
      let self = this
      const response = await fetch(
        'https://www.sayjack.com/korean/korean-hanja/characters/title:%E7%BE%85',
        {
          method: 'GET',
          headers: {
            accept: 'application/json',
          },
        },
      )

      console.log(response)
      let url =
        'https://protected-sierra-35008.herokuapp.com/https://www.sayjack.com/korean/korean-hanja/characters/title:%E7%BE%85' // url we get data from
      let dataArray = [] // we put data in this array
      // GET request for remote image in node.js
      axios({
        method: 'get',
        url: url,
      }).then(function (response) {
        console.log(response.data)
        let html = response.data

        let $ = cheerio.load(html)

        $('ul.tertiary li').each(function () {
          const title = $(this).find('h3').attr('aria-label')
          const image = $(this).find('img').attr('src')

          // putting data in array.

          dataArray.push({
            title: title,
            image: image,
          })
        })

        self.lastestArticles = dataArray // Here we assign value to vuejs variable

        console.log(dataArray)
      })
    },
  },
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
