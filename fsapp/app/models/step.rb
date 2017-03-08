class Step < ActiveRecord::Base
  validates :title, :todo, presence: true
  validates :done, inclusion: { in: [true, false] }

  belongs_to :todo, foreign_key: :todoId
end
