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
            "must contain at least a number and a symbol")
        end
    end
end

class User < ApplicationRecord
    has_secure_password
    has_many :reviews
    # creates a one-to-many relationship with games
    # user_id is a foreign key for games
    has_many :games
    
    acts_as_voter
    
    validates :username, presence: true #, uniqueness: true?
    validates :email, presence: true, uniqueness: true, email: true
    validates :password, length: { minimum: 8 }, password: true, on: :create

end



