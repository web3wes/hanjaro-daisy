<template>
  <div class="dashboard">
    <h2>These are your saved words</h2>
    <div class="overflow-x-auto">
      <table class="table w-full table-zebra mt-20">
        <thead>
          <tr>
            <th>Hangul</th>
            <th>Hanja</th>
            <th>English</th>
            <th></th>
          </tr>
        </thead>

        <tbody
          class="column is-4-desktop is-12-tablet is-12-mobile"
          :key="word.id"
          v-for="word in this.saveWords.data"
        >
          <tr>
            <td>없다</td>
            <td>{{ word.word }}</td>
            <td>{{ word.definitions }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
import Queries from '../services/query'
export default {
  name: 'Dashboard',
  // components: { ,  },

  data() {
    return {
      // nextPlanOptions: '',
      // nextPlanName: '',
      // currentPlan: '',
      saveWords: '',
    }
  },

  setup() {
    async function test() {
      // const unwrappedForm = form.value
      console.log('loading ')
      this.saveWords = await Queries.api.loadSavedWord({ saveWord: 'word' })
      console.log(this.saveWords.data[0].word)
    }
    return {
      test,
    }
  },

  methods: {},
  mounted() {
    this.test()
    console.log(this.saveWords)
    console.log('Saved words')
  },
}
</script>
