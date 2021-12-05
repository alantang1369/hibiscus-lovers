class Sale < ApplicationRecord
    belongs_to :user
    belongs_to :cultivar
    has_many :orders
    validates :cultivar_id, presence: true
    validates :available_seed, presence: true
    validates :seed_price, presence:true
    def cultivar_name= (name)
        self.cultivar = Cultivar.find_or_create_by(name: name) if !name.blank?
    end
 
    def cultivar_name
        self.cultivar ? self.cultivar.name : nil
    end
end
