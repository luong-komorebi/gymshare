class Exercise < ApplicationRecord
  belongs_to :user
  has_many :rounds

  validates :name, presence: true
  validates :description, presence: true
  validates_numericality_of :weight, :on => :create, message: "must be a number", :allow_nil => true
  validates_numericality_of :reps, :on => :create, message: "must be a number", :allow_nil => true, :only_integer => true
end
