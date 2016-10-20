class User < ActiveRecord::Base
#   has_secure_password
    has_many :weights
    has_many :categories, through: :weights
end
