class Show < ActiveRecord::Base
    belongs_to :provider
    has_one :user, through: :provider
end
  