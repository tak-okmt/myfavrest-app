class Like < ApplicationRecord
    belongs_to :user
    belongs_to :post, counter_cache: :likes_count
    validates :user_id, presence: true
    validates :post_id, presence: true

    validates :user_id, uniqueness: { scope: :post_id}
    validates :post_id, uniqueness: { scope: :user_id}
end
