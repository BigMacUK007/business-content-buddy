class Post < ApplicationRecord
  belongs_to :user
  acts_as_taggable_on :tags

  # Validations
  validates :title, presence: true
  validates :post_type, presence: true
  validates :day_of_week, presence: true
  validates :status, presence: true, inclusion: { in: %w[idea draft shipped] }

  # Scopes
  scope :ideas, -> { where(status: 'idea') }
  scope :drafts, -> { where(status: 'draft') }
  scope :shipped, -> { where(status: 'shipped') }
  scope :for_week, ->(date) { where('created_at >= ? AND created_at < ?', date.beginning_of_week, date.end_of_week) }

  # Constants for post types
  POST_TYPES = {
    'monday' => 'Authority',
    'tuesday' => 'Insight',
    'wednesday' => 'Tactical',
    'thursday' => 'Trend',
    'friday' => 'Proof',
    'saturday' => 'Conversation',
    'sunday' => 'Vision'
  }.freeze

  DAYS_OF_WEEK = %w[monday tuesday wednesday thursday friday saturday sunday].freeze

  # Methods
  def ship!
    update(status: 'shipped', shipped_at: Time.current)
  end

  def unship!
    update(status: 'draft', shipped_at: nil)
  end
end
