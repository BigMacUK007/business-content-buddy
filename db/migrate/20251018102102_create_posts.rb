class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :content
      t.string :post_type
      t.string :day_of_week
      t.string :status
      t.string :platform
      t.datetime :scheduled_for
      t.datetime :shipped_at

      t.timestamps
    end
  end
end
