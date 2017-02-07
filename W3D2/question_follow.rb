class QuestionFollow
  attr_reader :id
  attr_accessor :question_id, :user_id
  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM question_follows
      WHERE id = ?
    SQL
    return nil if data.empty?
    QuestionFollow.new(data.first)
  end

  def self.followers_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        question_follows
      JOIN
        users ON question_follows.user_id = users.id
      WHERE
        question_follows.question_id = ?
    SQL

    return nil if data.empty?
    data.map {|datum| User.new(datum)}
  end

  def self.followed_questions_for_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        question_follows
      JOIN
        questions ON question_follows.question_id = questions.id
      WHERE
        question_follows.user_id = ?
    SQL

    return nil if data.empty?
    data.map {|datum| Question.new(datum)}
  end

  def self.most_followed_questions(n)
    data = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        question_follows
      JOIN
        questions ON question_follows.question_id = questions.id
      GROUP BY
        question_id
      ORDER BY
        COUNT(*) DESC
      LIMIT ?
    SQL

    return nil if data.empty?
    data.map {|datum| Question.new(datum)}
  end
end
