class Rest < ApplicationRecord
  belongs_to :round

  validates :rest_time, presence: true
  validates_numericality_of :rest_time, :on => :create, message: "must be a number", :allow_nil => true
end
