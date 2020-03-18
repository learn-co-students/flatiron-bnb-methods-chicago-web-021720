class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review

  validates :checkin, :presence => true
  validates :checkout, :presence => true
  validate :guest_cannot_be_host
  validate :listing_available
  validate :checkin_and_checkout

  def guest_cannot_be_host
    if self.guest == self.listing.host
      errors.add(:guest, "can't be the host")
    end
  end
  
  def listing_available
    return if self.checkin == nil || self.checkout == nil
    if self.listing.any_reservations?(self.checkin.to_s, self.checkout.to_s) == true
      errors.add(:checkin, "listing is unavailable during this time")
      errors.add(:checkout, "listing is unavailable during this time")
    end
  end
  
  def checkin_and_checkout
    return if self.checkin == nil || self.checkout == nil
    if self.checkin > self.checkout
      errors.add(:checkin, "checkin date must be before checkout")
    end
    if self.checkin == self.checkout
      errors.add(:checkout, "checkout date cannot be same as checkin")
    end
  end

  def duration
    self.checkout - self.checkin
  end

  def total_price
    self.duration * self.listing.price
  end

end
