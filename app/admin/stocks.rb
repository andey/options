ActiveAdmin.register Stock do
  permit_params :ticker

  index pagination_total: false do
    column :updated_at
    column :ticker
    column :name
    column :price
    column :volume
    actions
  end
end
