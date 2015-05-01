class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :comment, length: { minimum: 5 }
  validates :body, presence: true
  validates :user_id, presence: true
end
