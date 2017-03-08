class Tagging < ActiveRecord::Base
  validates :todo_id, :tag_id, presence: true

  belongs_to :tag
  belongs_to :todo
end
