class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates :comment, length: {minimum:4}

  scope :past, -> {where("created_at <= ?", Time.now)}
  scope :past_n_days, ->(days) { past.where("created_at < ?", days.days.ago) }


  STARS = [
  	1,
  	2,
  	3,
  	4,
  	5
  ]
  validates :stars, inclusion: {in: STARS,
  message: "must be between 1 and 5"}
end
