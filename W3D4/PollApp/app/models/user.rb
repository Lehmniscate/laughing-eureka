# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true

  has_many :authored_polls,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Poll

  has_many :responses,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Response

  # def completed_polls
  #   Poll.joins(:questions)
  #   .joins()
  #   .group(:poll_id)
  #   .having("COUNT(questions.id) = COUNT(r.question_id)")
  # end

  def completed_polls_with_sql
    Poll.find_by_sql([<<-SQL, id])
      SELECT polls.*
      FROM polls
      JOIN questions ON questions.poll_id = polls.id
      LEFT JOIN (
          SELECT *
          FROM answer_choices
          JOIN responses ON answer_choices.id = responses.answer_choice_id
          WHERE responses.user_id = ?
        ) AS user_responses ON user_responses.question_id = questions.id
      GROUP BY polls.id
      HAVING COUNT(questions.id) = COUNT(user_responses.question_id)
    SQL
  end

end
