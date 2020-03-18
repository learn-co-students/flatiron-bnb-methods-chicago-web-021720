class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods

  include Shared::InstanceMethods
  extend Shared::ClassMethods
  
  def city_openings(start_date, end_date)
    self.openings(start_date, end_date)
  end

  # def self.highest_ratio_res_to_listings
  #   self.all.max do |city_1, city_2|
  #     city_1.ratio_res_to_listings <=> city_2.ratio_res_to_listings
  #   end
  # end

  # def self.most_res
  #   self.all.max do |city_1, city_2|
  #     city_1.total_reservations <=> city_2.total_reservations
  #   end
  # end
  
  # def ratio_res_to_listings
  #   num_listings = self.listings.count
  #   num_reservations = self.total_reservations
  #   num_reservations / num_listings.to_f
  # end

  # def total_reservations
  #   self.listings.map {|listing| listing.reservations.count}.sum
  # end
end

