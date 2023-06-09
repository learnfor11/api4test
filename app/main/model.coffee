init_model = require '../pop/model'

module.exports = ->
  model = init_model()
  return (ctx, next) ->
    if ctx.knex
      throw Error 'ctx.knex is already defined'
    ctx.knex = model
    return next()
