class RemoveColumnsFromProducts < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :stripe_plan_name, :string
    remove_column :products, :price_cent, :integer
  end
end
