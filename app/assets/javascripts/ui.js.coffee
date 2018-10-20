$(document).ready ->
  $('#datatable').DataTable(
    "processing": true,
    "serverSide": true,
    "language": {
      "search": "ticker:"
    }
    "ajax": "/api/v1/options",
    "order": [[ 6, "desc" ]]
    "columns": [
      {"data": "symbol", "name": "symbol", "title": "option"},
      {"data": "updated_at", "name": "updated_at", "title": "updated at"},
      {"data": "expires_at", "name": "expires_at", "title": "expires at"},
      {"data": "strike", "name": "strike", "title": "strike"},
      {"data": "price", "name": "price", "title": "price"},
      {"data": "volume", "name": "volume", "title": "volume"},
      {"data": "yield", "name": "yield", "title": "yield"}
    ]
  )