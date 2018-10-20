json.recordsTotal Option.count
json.recordsFiltered @options.count
json.data @options.order("#{sort_column} #{sort_direction}").page(page).per(params[:length])