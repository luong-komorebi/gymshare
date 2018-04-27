class Round < ApplicationRecord
  has_many :exercises, inverse_of: :round
  accepts_nested_attributes_for :exercises
  has_many :rests
  belongs_to :workout_plan
  validates :repitition, numericality: { greater_than_or_equal_to: 1 } 

  def as_json(options={})
    super(include: { exercises: { include: :exercises }, rests: { include: :rests } })
  end
end
