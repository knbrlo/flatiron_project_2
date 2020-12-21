class User < ActiveRecord::Base
    has_many :notes
    has_secure_password
    validates :email, :username, presence: true
    validates :email, :username, uniqueness: true
end
  