class AddColumnsToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :state, :string
    add_column :orders, :product_sku, :string
    #add_column :orders, :amount, :monetize
    add_column :orders, :checkout_session_id, :string
  end
end
