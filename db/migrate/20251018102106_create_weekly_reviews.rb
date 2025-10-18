class CreateWeeklyReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :weekly_reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.date :week_start
      t.integer :posts_count
      t.json :engagement_stats
      t.text :insights
      t.text :focus_next_week

      t.timestamps
    end
  end
end
