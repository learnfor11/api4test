log = require '@ppzp/log'

id = 0n
module.exports = (ctx, next) ->
  if ctx.id != undefined
    throw Error 'ctx.id is already exist'
  ctx.id = ++id
  if ctx.log != undefined
    throw Error 'ctx.log is already exist'
  ctx.log = new Proxy log, {
    get: (_, type) -> ->
      log[type] 'ctx_id_' + ctx.id, ...arguments
  }
  
  ctx.log.debug ctx.method, ctx.path
  await next()
  ctx.log.debug 'finish', ctx.method, ctx.path
