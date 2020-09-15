class ChangeLocationToBeAddress < ActiveRecord::Migration[6.0]
  def change
    rename_column :products, :location, :address
  end
end
