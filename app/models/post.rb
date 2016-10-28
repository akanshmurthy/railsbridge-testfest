class Post < ActiveRecord::Base
  belongs_to :user
  has_many :replies
  validates :title, :user_id, :content, presence: true
end
