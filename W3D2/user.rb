require_relative "modelbase"


class User < ModelBase
  TABLE = "users"

  attr_reader :id
  attr_accessor :fname, :lname

  def initialize(options)
    @id = options['id']
    @fname, @lname = options['fname'], options['lname']
  end

  def average_karma
    data = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        AVG(karma) AS average_karma
      FROM (
        SELECT
          COUNT(*) AS karma, questions.id AS q
        FROM
          questions
        JOIN
          question_likes ON questions.id = question_likes.question_id
        WHERE
          questions.author_id= ?
        GROUP BY
          questions.id
        ) AS karmas
      GROUP BY
        q
    SQL
    return 0 if data.empty?
    data.first['average_karma']
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def authored_replies
    Reply.find_by_author_id(@id)
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def self.find_by_name(fname, lname)
    data = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT *
      FROM users
      WHERE fname = ?
      AND lname = ?
    SQL
    return nil if data.empty?
    User.new(data.first)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

end
