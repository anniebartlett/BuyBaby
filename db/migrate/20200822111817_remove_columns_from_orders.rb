class RemoveColumnsFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :completed, :boolean
    remove_column :orders, :price_cent, :integer
  end
end
