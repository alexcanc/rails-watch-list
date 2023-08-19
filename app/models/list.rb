# app/models/list.rb
class List < ApplicationRecord

  include PgSearch::Model
  pg_search_scope :search_by_name,
    against: :name,
    using: {
      tsearch: { prefix: true }
    }

  has_many :bookmarks, dependent: :destroy
  has_many :movies, through: :bookmarks
  has_many :reviews, dependent: :destroy
  has_one_attached :image


  validates :name, presence: true, uniqueness: true
end
