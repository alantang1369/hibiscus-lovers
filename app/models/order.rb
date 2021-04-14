class Order < ApplicationRecord
    belongs_to :sale

    def place_order
        current_user.wallet -= self.total
        current_user.save
        self.sale.available_seed -= self.seed_amount
        sale.save
    end

end
