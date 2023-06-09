Path = require 'path'
FS = require 'fs'
restful_api = require '../pop/api/_restful_api'
log = require '@ppzp/log'

module.exports = (app) ->
  # 读取全部 api 目录下的文件
  apis = FS.readdirSync Path.join(__dirname, '../pop/api')
    .filter (filename) => filename[0] != '_'
    .map (filename) ->
      init_api = require('../pop/api/' + filename)
      if init_api instanceof Function
        log.info('new api', filename)
        return init_api
      else
        log.info('new simple api', filename)
        return restful_api.simple(filename.split('.')[0])
  for init_api in apis
    router = init_api()
    app
      .use router.routes()
      .use router.allowedMethods()
