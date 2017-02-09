# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  poll_id    :integer          not null
#  text       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ActiveRecord::Base
  validates :poll_id, :text, presence: true

  has_many :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :AnswerChoice

  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: :Poll

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def results
    AnswerChoice.joins(:question)
    .joins("LEFT JOIN responses ON answer_choices.id  = responses.answer_choice_id")
    .where("questions.id = ?", self.id)
    .group(:id)
    .pluck(:text, "COUNT(responses.id) AS count").to_h
  end

end
