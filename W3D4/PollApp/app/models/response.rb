# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  answer_choice_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, presence: true
  validate :not_duplicate_response

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: :AnswerChoice

  has_one :question,
    through: :answer_choice,
    source: :question

  private

  def not_duplicate_response
    if respondent_already_answered?
      errors[:Respondent] << "has already answered this question"
    end
  end

  def respondent_already_answered?
    sibling_responses.where(user_id: user_id).exists?
  end

  def sibling_responses
    question.responses.where.not(id: id)
  end

end
