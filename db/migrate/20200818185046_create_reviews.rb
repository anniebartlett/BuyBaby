class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.integer :user_id
      t.integer :rating
      t.integer :reviewer_id
      t.integer :reviewed_id

      t.timestamps
    end
  end
end
