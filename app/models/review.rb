class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, :class_name => "User"

  validates :rating, :presence => true
  validates :description, :presence => true
  validates :reservation_id, :presence => true
  validate :accepted_reservation, :checked_out

  def accepted_reservation
    return if self.reservation_id == nil
    if self.reservation.status != "accepted"
      errors.add(:reservation, "your reservation was not accepted")
    end
  end
  
  def checked_out
    return if self.reservation_id == nil
    if self.reservation.checkout > Date.today
      errors.add(:reservation, "your checkout date has not passed")
    end
  end

end
