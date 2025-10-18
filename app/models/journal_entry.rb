class JournalEntry < ApplicationRecord
  belongs_to :user
  acts_as_taggable_on :tags

  # Validations
  validates :content, presence: true

  # Constants
  ENTRY_TYPES = %w[pain lesson framework trend proof].freeze

  # Scopes
  scope :recent, -> { order(created_at: :desc) }
end
