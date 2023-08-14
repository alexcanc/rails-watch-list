# app/models/movie.rb
class Movie < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_title_and_overview,
    against: [:title, :overview],
    using: {
      tsearch: { prefix: true }
    }

  # Associations
  has_many :bookmarks

  # Validations
  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true
end
