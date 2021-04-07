class User < ApplicationRecord
    has_secure_password
    has_many :sales
    has_many :cultivars, through: :sales
    
end
