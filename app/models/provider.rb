class Provider < ActiveRecord::Base
    has_many :shows
    belongs_to :user

    # todo - char - user should have full crud over this.
    # 7 restful routes
    
end
  