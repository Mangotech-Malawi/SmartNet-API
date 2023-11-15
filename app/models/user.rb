class User < ApplicationRecord
    has_secure_password

    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :username, presence: true
    validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

    belongs_to :person

    validate :validate_uniqueness_if_not_voided

    private
    def validate_uniqueness_if_not_voided
        return if self.voided?

        if User.where.not(id: id).where(email: email, voided: false).exists?
        errors.add(:email, "has already been taken")
        end

        if User.where.not(id: id).where(username: username, voided: false).exists?
        errors.add(:username, "has already been taken")
        end
    end
end