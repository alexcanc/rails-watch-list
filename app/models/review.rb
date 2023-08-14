class Review < ApplicationRecord
  belongs_to :list
  validates :content, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5 } # Make sure rating is between 1 and 5
end
