function update_updated_at(record) {
  record.updated_at = new Date()
}

exports.update = async function simple_update(table, id, record) {
  update_updated_at(record)
  return await table.where('id', id).update(record)
}
