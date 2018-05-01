class Round < ApplicationRecord
  has_many :exercises, inverse_of: :round, dependent: :destroy
  accepts_nested_attributes_for :exercises
  has_many :rests, dependent: :destroy, inverse_of: :round
  belongs_to :workout_plan
  validates :repitition, numericality: { greater_than_or_equal_to: 1 } 

  def as_json(options={})
    super(include: [:exercises, :rests])
  end
end
