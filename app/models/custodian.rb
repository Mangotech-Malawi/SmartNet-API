class Custodian < ApplicationRecord
    validates :custodian_type_id, presence: true
    validates :custodian_type, presence: true
    has_many  :person
    has_many  :department
end
