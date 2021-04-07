class Sale < ApplicationRecord
    belongs_to :user
    belongs_to :cultivar
    has_many :orders
end
