Router = require '@koa/router'

exports.simple = (config, init_api) -> ->
  if init_api == undefined
    init_api = config
    config = undefined
  # 实例化 koa router
  router = new Router config
  # 收集 route 小能手 —— PPz
  PPz = (method) -> (path, ...middlewares) ->
    if path instanceof Function
      middlewares.unshift(path)
      path = '/'
    router[method](path, ...middlewares)
  # 收！
  init_api {
    GET: PPz 'get'
    POST: PPz 'post'
    DELETE: PPz 'delete'
  }
  return router
