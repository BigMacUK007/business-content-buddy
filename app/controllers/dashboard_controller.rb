class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @current_week_start = Date.today.beginning_of_week
    @posts_by_day = Post::DAYS_OF_WEEK.index_with do |day|
      current_user.posts.where(day_of_week: day).for_week(@current_week_start).order(:created_at)
    end
    @recent_journal_entries = current_user.journal_entries.recent.limit(5)
    @recent_proof_items = current_user.proof_items.recent.limit(5)
    @weekly_streak = calculate_streak
  end

  private

  def calculate_streak
    # Simple streak calculation - count consecutive weeks with at least 4 posts
    streak = 0
    week_start = Date.today.beginning_of_week
    
    loop do
      posts_count = current_user.posts.shipped.for_week(week_start).count
      break if posts_count < 4
      
      streak += 1
      week_start -= 1.week
    end
    
    streak
  end
end
