Path = require 'path'

development =
  server:
    port: 8888
  database:
    client: 'better-sqlite3'
    connection:
      filename: Path.join __dirname, 'database/db.sqlite3'
  blockchain:
    contract:
      nybl: '0x7Cc0326f71A4c2457d6294637fEB0C123e68b1B3'
    url: [
      'https://data-seed-prebsc-1-s1.binance.org:8545/'
    ]

module.exports = development
