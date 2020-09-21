class AddColumnToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :sale_type, :string
  end
end
