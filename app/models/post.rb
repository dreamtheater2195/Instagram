class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :notifications, dependent: :destroy  

    validates :user_id, presence: true
    validates :image, presence: true
    validates :description, length: { minimum: 3, maximum: 300 }

    has_attached_file :image, styles: { medium: "640x600#", small: "300x300#" }
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

    acts_as_votable

    scope :of_followed_users, -> (following_users) { where user_id: following_users }
end
