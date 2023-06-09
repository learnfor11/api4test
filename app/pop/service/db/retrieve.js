exports.retrieve_by_id = async function(table, id) {
  if(id instanceof Array)
    return await table.whereIn('id', id)
  else
    return (await table.where('id', id))[0]
}
