class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings

  include Shared::InstanceMethods
  extend Shared::ClassMethods
  
  def neighborhood_openings(start_date, end_date)
    self.openings(start_date, end_date)
  end

end
