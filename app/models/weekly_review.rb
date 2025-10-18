class WeeklyReview < ApplicationRecord
  belongs_to :user

  # Validations
  validates :week_start, presence: true

  # Scopes
  scope :recent, -> { order(week_start: :desc) }
end
