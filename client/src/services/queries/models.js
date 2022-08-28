import Model, { fields } from '@thinknimble/tn-models'

import UserAPI from './api'

export default class Query extends Model {
  static fullName = new fields.CharField({ readOnly: true })
}
