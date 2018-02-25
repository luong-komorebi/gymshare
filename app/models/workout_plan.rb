class WorkoutPlan < ApplicationRecord
  has_many :rounds
  belongs_to :user
  validates :name, presence: true
  validates :description, presence: true
end
