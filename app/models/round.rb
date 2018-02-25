class Round < ApplicationRecord
  has_many :exercises
  has_many :rests
  belongs_to :workout_plan
end
