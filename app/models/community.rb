class Community < ApplicationRecord
    validates  :name, uniqueness: { scope: :create_user_id}
    belongs_to :create_user, class_name: "User"
end
