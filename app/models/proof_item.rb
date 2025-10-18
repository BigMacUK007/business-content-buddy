class ProofItem < ApplicationRecord
  belongs_to :user

  # Validations
  validates :title, presence: true
  validates :proof_type, presence: true

  # Constants
  PROOF_TYPES = %w[testimonial metric screenshot win stat link].freeze

  # Scopes
  scope :recent, -> { order(created_at: :desc) }
end
