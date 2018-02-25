class Round < ApplicationRecord
  has_many :exercises
  has_many :rests
  belongs_to :workout_plan
  validates :repitition, numericality: { greater_than_or_equal_to: 1 }
end
