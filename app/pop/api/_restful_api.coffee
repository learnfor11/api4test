{ simple: simple_base } = require './_base'
{ retrieve_by_id, insert, update, del_by_id } = require '../service/db'

exports.get_all = (GET, table_name) -> # 一次性获取**所有**数据
  GET ({ respond, knex }) ->
    respond.json await knex[table_name]

exports.get_by_id = (GET, table_name) -> # 通过 id 获取
  GET '/:id', ({ params, respond, knex }) ->
    respond.json await retrieve_by_id(knex[table_name], params.id)

exports.create = (POST, table_name) ->
  POST ({ request, respond, knex }) ->
    respond.str(
      await insert(knex[table_name], request.body)
    )

exports.update = (POST, table_name) ->
  POST '/:id', ({ request, params, respond, knex }) ->
    respond.str(
      await update(knex[table_name], params.id, request.body)
    )

exports.del = (DELETE, table_name) ->
  DELETE '/:id', ({ params, respond, knex }) ->
    respond.str(
      await del_by_id(knex[table_name], params.id)
    )

exports.get = (router, table_name) ->
  exports.get_all router.GET, table_name
  exports.get_by_id router.GET, table_name

exports.all = (router, table_name) ->
  exports.get_all router.GET, table_name
  exports.get_by_id router.GET, table_name
  exports.create router.POST, table_name
  exports.update router.POST, table_name
  exports.del router.DELETE, table_name

exports.simple = (table_name) ->
  return simple_base(
    prefix: '/' + table_name

    (router) -> exports.all(router, table_name)
  )
