class Person < ApplicationRecord
    validates :firstname, presence: true
    validates :lastname, presence: true
    validates :national_id, presence: true
    has_many :user
end
