import Model, { fields } from '@thinknimble/tn-models'

import QueryAPI from './api'

export default class Queries extends Model {
  static api = QueryAPI.create('word')
  static fullName = new fields.CharField({ readOnly: true })
}
