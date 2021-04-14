class Sale < ApplicationRecord
    belongs_to :user
    belongs_to :cultivar
    has_many :orders

    def cultivar_name= (name)
        self.cultivar = Cultivar.find_or_create_by(name: name)
    end

    def cultivar_name
        self.cultivar ? self.cultivar.name : nil
    end
end
