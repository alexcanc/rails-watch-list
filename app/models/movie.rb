# app/models/movie.rb
class Movie < ApplicationRecord
  # Associations
  has_many :bookmarks

  # Validations
  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true
end
