class User < ActiveRecord::Base
    has_many :providers
    has_many :shows, through: :providers

    # todo - char - use a has_secure_password macro
    validates :email, :username, presence: true
    validates :email, :username, uniqueness: true

end
  