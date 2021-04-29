class Cultivar < ApplicationRecord 
    has_many :sales
    has_many :users, through: :sales
    validates :cultivar, presence: true
    validates :available_seed, presence: true
    def availability
        if self.sales.any? {|sale| sale.available_seed > 0} 
            self.status = "on-sale"
        end
        status
    end
end
