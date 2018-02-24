class Round < ApplicationRecord
  has_many :exercise
  has_many :rest
  belongs_to :workout_plan
end
