class User < ApplicationRecord
    has_secure_password 
    has_many :sales
    has_many :cultivars, through: :sales
    has_many :orders
    validates :name, presence: true
    validates :name, uniqueness: true
    validates :email, uniqueness: true
    validates :email, presence: true
end
