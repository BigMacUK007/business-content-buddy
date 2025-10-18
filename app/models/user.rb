class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :posts, dependent: :destroy
  has_many :journal_entries, dependent: :destroy
  has_many :proof_items, dependent: :destroy
  has_many :weekly_reviews, dependent: :destroy

  # Validations
  validates :name, presence: true
end
