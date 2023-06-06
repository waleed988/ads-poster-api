class Ad < ApplicationRecord
  validates :title, presence: true 
  validates :featured, presence: true
  validates :brand_name, presence: true
  validates :price, presence: true
  validates :leased, presence: true
  validates :location, presence: true
  validates :transmission_type, presence: true
  
  has_many_attached:images
  belongs_to :user
  has_many :views
  
  scope :filter_by_title, -> (title) { where title: title }
  scope :filter_by_location, -> (location) { where location: location }
  scope :filter_by_featured, -> (featured) { where featured: featured }
  scope :filter_by_price, -> (min, max) {where(price: min..max) }
  scope :filter_by_transmission_type, -> (transmission_type) { where transmission_type: transmission_type }
  scope :filter_by_brand_name, -> (brand_name) { where brand_name: brand_name }


end
