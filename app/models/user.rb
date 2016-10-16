class User < ApplicationRecord
    acts_as_voter
    
    has_many :posts
    has_many :comments, dependent: :destroy
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    has_attached_file :avatar, styles: { medium: '152x152#' }  
    validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
