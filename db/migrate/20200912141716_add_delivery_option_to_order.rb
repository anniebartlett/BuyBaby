class AddDeliveryOptionToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :delivery_option, :string
    add_column :orders, :payment_option, :string
  end
end
