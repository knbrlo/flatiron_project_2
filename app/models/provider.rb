class Provider < ActiveRecord::Base
    has_many :shows
    belongs_to :user
end
  