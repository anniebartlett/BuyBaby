class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :location
      t.string :condition
      t.string :size
      t.string :colour
      t.string :payment_options
      t.string :category
      t.string :stripe_plan_name
      t.integer :price_cent
      t.string :deliver_option
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
