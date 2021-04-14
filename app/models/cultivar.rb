class Cultivar < ApplicationRecord 
    has_many :sales
    has_many :users, through: :sales

    def availability
        if self.sales.any? {|sale| sale.available_seed > 0} 
            self.status = "on sale"
        end
        status
    end
end
