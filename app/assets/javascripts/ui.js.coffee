$(document).ready ->
  $('#datatable').DataTable(
    "processing": true,
    "serverSide": true,
    "ajax": "/api/v1/options",
    "columns": [
      {"data": "id"},
      {"data": "created_at"},
      {"data": "updated_at"},
      {"data": "stock_id"},
      {"data": "symbol"},
      {"data": "expires_at"},
      {"data": "strike"},
      {"data": "price"},
      {"data": "volume"},
      {"data": "yield"}
    ]
  )