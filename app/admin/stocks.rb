ActiveAdmin.register Stock do
  permit_params :ticker, :expiry_dates

  member_action :fetch, method: :get
  action_item :fetch, only: :show do
    link_to 'fetch', fetch_admin_stock_path(resource)
  end

  index pagination_total: false do
    column :updated_at
    column :ticker
    column :name
    column :price
    column :volume
    actions
  end

  controller do
    def fetch
      resource.fetch()
      redirect_to admin_stock_path(resource)
    end
  end
end
