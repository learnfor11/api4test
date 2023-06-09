{ UNKOWN_ERROR, StatusCodes } = require './catch_error'

class Respond
  constructor: (@ctx) ->
    @_responded = false # read only

  __mark_responded: (code) ->
    if @_responded
      throw Error 'already responded'
    if code
      @ctx.response.status = code
    @_responded = true
  
  json: (data, code) ->
    @__mark_responded code
    @ctx.body = data
  
  str: (msg, code) ->
    @__mark_responded code
    @ctx.body = msg
  
  _: ->
    @__mark_responded() # 只应在成功时（code: 200），使用“无内容响应）
    @ctx.body = ''

  unknown_error: ->
    @str UNKOWN_ERROR, StatusCodes.INTERNAL_SERVER_ERROR

make_response_middleware = (_Respond = Respond) -> (ctx, next) ->
  unless ctx.respond == undefined
    throw Error 'ctx.respond already exists'
  ctx.respond = new _Respond ctx
  await next()
  unless ctx.respond._responded # 确保有响应
    throw Error 'no response'

module.exports = {
  Respond
  make_response_middleware
}