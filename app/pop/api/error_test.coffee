{ simple } = require './_base'
{ StatusCodes, SafeError, UnsafeError } = require '../middleware/catch_error'

# 创建 router 对象的参数
module.exports = simple(
  prefix: '/error'
  
  ({ GET }) ->
    GET '/safe', (ctx) ->
      ctx.respond.json(
        key1: 'value'
        key2: 2
        
        StatusCodes.BAD_REQUEST
      )
      throw new SafeError 'ppz\'s test for "throw SafeError(xxx)"'

    GET '/unsafe', (ctx) ->
      throw new UnsafeError 'ppz\'s test for "throw UnsafeError(xxx)"'
    
    GET '/dont_throw_error', (ctx) ->
      throw new Error '不应在代码里直接 throw Error'
)
