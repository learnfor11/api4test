# API 4 少爷
[接口文档](https://www.postman.com/one1202/workspace/11/collection/4866616-ab4a5803-7de0-48c9-9cd3-cfea9d7f2d97)

## 部署
##### 运行时环境
+ nodejs（[官网下载](https://nodejs.org/en)）
+ coffeescript（`npm install -g coffeescript`）

##### 开启
下载代码
``` bash
git clone git@github.com:learnfor11/api4test.git
```

安装依赖
``` bash
cd api4test
npm install
```

初始化数据库
``` bash
coffee ./app/database/20230609.coffee
```

启动服务器
``` bash
npm run dev
```
