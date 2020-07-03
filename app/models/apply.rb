class Apply < ApplicationRecord
    belongs_to :user
    belongs_to :community
    validates :user_id, presence: true
    validates :community_id, presence: true
    validates  :user_id, uniqueness: { scope: :community_id}
    validates  :community_id, uniqueness: { scope: :user_id}

end
