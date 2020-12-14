class User < ActiveRecord::Base
    has_many :providers
    has_many :shows, through: :providers

    validates :email, :password, :username, presence: true
    validates :email, :username, uniqueness: true

end
  