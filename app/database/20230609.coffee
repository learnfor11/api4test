Knex = require 'knex'
Config = require '../config'
log = require '@ppzp/log'

create_table = (knex) ->
  await knex.schema.createTable 'user', (_) ->
    _.uuid('id').primary().notNullable()
    _.string('name')
    _.integer('gender')
    _.string('phone')
    _.timestamps()
  log.info 'created table user'

  # await knex.schema.createTable 'address', (_) ->

do ->
  knex = Knex Config.database
  await create_table knex
  log.info 'done'
  process.exit()
