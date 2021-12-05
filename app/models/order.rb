class Order < ApplicationRecord
    belongs_to :sale
    belongs_to :user

    def place_order
        user.wallet -= self.total
        user.save
        self.sale.user.wallet += self.total
        self.sale.user.save
        self.sale.available_seed -= self.seed_amount
        self.sale.save
        self.update(confirm: true)
        
    end

    def self.user_orders(user)
        where(user_id: user.id)
    end

end
