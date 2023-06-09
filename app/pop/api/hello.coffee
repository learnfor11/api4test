Router = require '@koa/router'

module.exports = ->
  router = new Router()

  router.get '/hello', (ctx) ->
    ctx.respond.str 'Hello you!'

  return router
