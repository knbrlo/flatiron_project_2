class User < ActiveRecord::Base
    has_many :providers
    has_many :shows, through: :providers
end
  