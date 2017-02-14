class ContactShare < ActiveRecord::Base
  validates :contact_id, uniqueness: {scope: :user_id}
  validates :contact_id, :user_id, presence: true

  belongs_to :contact
  belongs_to :user

  has_many :comments, as: :comment_id
end
