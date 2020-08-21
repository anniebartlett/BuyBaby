class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.boolean :completed, default: false
      t.integer :price_cent
      t.references :user

      t.timestamps
    end
  end
end
