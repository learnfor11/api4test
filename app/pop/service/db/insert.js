const { v4: uuid } = require('uuid')

function add_timestamps(record) {
  record.created_at = new Date()
  record.updated_at = new Date()
}

function add_id(record) {
  record.id = uuid()
}

exports.insert = async function simple_insert(table, record) {
  add_id(record)
  add_timestamps(record)
  await table.insert(record)
  return record.id
}
