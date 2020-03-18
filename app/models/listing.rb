class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations

  validates :address, :presence => true
  validates :listing_type, :presence => true
  validates :title, :presence => true
  validates :price, :presence => true
  validates :description, :presence => true
  validates :neighborhood_id, :presence => true

  after_create :user_to_host
  after_destroy :remove_host_from_user

  include Shared::InstanceMethods

  def average_review_rating
    total_rating = self.reviews.map {|rev| rev.rating}.sum
    num_ratings = self.reviews.count
    total_rating / num_ratings.to_f
  end

  private

  def user_to_host
    self.host.update(host: true)
  end

  def remove_host_from_user
    if self.host.listings.empty?
      self.host.update(host: false)
    end
  end
end
