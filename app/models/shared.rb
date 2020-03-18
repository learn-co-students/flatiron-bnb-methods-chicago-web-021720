module Shared
    module InstanceMethods
        def openings(start_date, end_date)
            self.listings.select do |listing|
                listing.any_reservations?(start_date, end_date) == false
            end
        end

        def any_reservations?(start_date, end_date)
            self.reservations.any? {|res| ((res.checkin <= Date.parse(end_date)) & (Date.parse(start_date) <= res.checkout)) == true }
        end

        def ratio_res_to_listings
            num_listings = self.listings.count
            num_reservations = self.total_reservations
            if num_listings == 0
                return 0
            else
                num_reservations / num_listings.to_f
            end
        end
    
        def total_reservations
            self.listings.map {|listing| listing.reservations.count}.sum
        end
    end

    module ClassMethods
        def highest_ratio_res_to_listings
            self.all.max do |a, b|
              a.ratio_res_to_listings <=> b.ratio_res_to_listings
            end
        end

        def most_res
            self.all.max do |a, b|
              a.total_reservations <=> b.total_reservations
            end
        end
    end 
end