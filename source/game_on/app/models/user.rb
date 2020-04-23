class EmailValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        unless value =~ 
            /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
            record.errors[attribute] << (options[:message] ||
            "is not a vaild email")
        end
    end
end

class PasswordValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        unless value =~
            /(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[^a-zA-Z0-9])/
            record.errors[attribute] << (options[:message] ||
            "is not a vaild password")
        end
    end
end

class User < ApplicationRecord
    has_secure_password

    validates :username, presence: true #, uniqueness: true?
    validates :email, presence: true, uniqueness: true, email: true
    validates :password, length: { minimum: 8 }, password: true

end

