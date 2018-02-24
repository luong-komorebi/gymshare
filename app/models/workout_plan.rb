class WorkoutPlan < ApplicationRecord
  has_many :round
  belongs_to :user
end
