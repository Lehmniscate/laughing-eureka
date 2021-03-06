class Contact < ActiveRecord::Base
  validates :name, :email, :user_id, presence: true
  validates :email, uniqueness: {scope: :user_id}

  belongs_to :user

  has_many :contact_shares

  has_many :shared_users,
    through: :contact_shares,
    source: :user

  has_many :comments, as: :comment_id

  has_many :contact_groups
end
