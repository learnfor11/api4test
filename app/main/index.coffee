
Koa = require 'koa'
BodyParser = require 'koa-bodyparser'
KoaSession = require 'koa-session'
log = require '@ppzp/log'

Config = require('../config')
debug_middleware = require '../pop/middleware/debug'
{ catch_middleware } = require '../pop/middleware/catch_error'
{ make_response_middleware } = require('../pop/middleware/response')

init_router = require('./router')
make_model_middleware = require('./model')

do ->
  log.info '少爷的专属服务器 starting'
  log.info 'Config:', JSON.stringify Config
  app = new Koa()

  # debug
  app.use debug_middleware
  # 捕获异常、响应异常
  app.use catch_middleware
  # http response: 加装 ctx.respond
  app.use make_response_middleware()
  # http request support json, form, test. for multipart use @koa/multer
  app.use BodyParser()
  # db: 加装 ctx.knex
  app.use make_model_middleware()
  # session
  app.keys = ['PPZ']
  app.use KoaSession app
  
  init_router app

  app.listen(
    Config.server.port
    ->
      log.info '少爷的专属服务器 started on', Config.server.port
  )
