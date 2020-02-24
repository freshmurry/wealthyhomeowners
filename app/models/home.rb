class Home < ApplicationRecord
  enum instant: {Request: 0, Instant: 1}
  
  belongs_to :user
  has_many :photos
  has_many :reservations
  
  has_many :guest_reviews
  # has_many :calendars
   
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  
  validates :home_type, presence: true
  validates :bedrooms, presence: true
  validates :bathrooms, presence: true
  validates :listing_name, presence: true, length: {maximum: 50}
  validates :summary, presence: true, length: {maximum: 500}
  validates :address, presence: true

  def cover_photo(size)
    if self.photos.length > 0
      self.photos[0].image.url(size)
    else
      "blank.jpg"
    end
  end
  
  def average_rating
    guest_reviews.count == 0 ? 0 : guest_reviews.average(:star).round(2).to_i
  end
end