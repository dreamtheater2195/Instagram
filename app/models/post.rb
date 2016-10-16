class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_attached_file :image, styles: { medium: "640x600#", small: "300x300#" }
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

    acts_as_votable
end
