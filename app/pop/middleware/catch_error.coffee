# https://www.npmjs.com/package/http-status-codes?activeTab=code

{ StatusCodes } = require 'http-status-codes/build/cjs/status-codes'
UNKOWN_ERROR = 'Unknown Error'

class _PPZError extends Error
  constructor: (message, @log) ->
    super(message)

class SafeError extends _PPZError # 用以提前结束 pop
class UnsafeError extends _PPZError

catch_middleware = (ctx, next) ->
  try
    await next()
  catch err
    if err instanceof SafeError
      if ctx.respond._responded # !!! “写入响应流”时，不会引发的 SafeError，因此 _responded 是真的成功了
        ctx.log.error '[safe error]', err.message
      else
        ctx.log.error 'bug: caught SafeError, but not responded, maybe forgot?:'
        console.error err
        ctx.respond.unknown_error()
    else
      if ctx.respond._responded # unsafe 不应该有响应！
        ctx.log.error 'bug: caught UnsafeError, but reponded, ???:'
      console.error err
      unless ctx.respond._responded
        ctx.respond.unknown_error()

module.exports = {
  StatusCodes
  catch_middleware
  UNKOWN_ERROR

  SafeError
  UnsafeError
}