Knex = require 'knex'
Config = require '../../config'

module.exports = ->
  new Proxy(
    Knex Config.database
    {
      get: (knex, table_name) -> # 允许任意的 table name
        # 复杂的 db 逻辑，在 service 里做
        return knex table_name
    }
  )
