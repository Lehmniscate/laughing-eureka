class QuestionLike
  attr_reader :id
  attr_accessor :user_id, :question_id
  def initialize(options)
    @id = options['id']
    @user_id, @question_id = options['user_id'], options['question_id']
  end

  def self.most_liked_questions(n)
    data = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        question_likes
      JOIN
        questions ON question_likes.question_id = questions.id
      GROUP BY
        question_id
      ORDER BY
        COUNT(*) DESC
      LIMIT ?
    SQL

    return nil if data.empty?
    data.map {|datum| Question.new(datum)}
  end

  def self.liked_questions_for_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        question_likes
      JOIN
        questions ON question_likes.question_id = questions.id
      WHERE
        question_likes.user_id = ?
    SQL

    return nil if data.empty?
    data.map {|datum| Question.new(datum)}
  end

  def self.num_likes_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*) AS count
      FROM
        question_likes
      JOIN
        users ON question_likes.user_id = users.id
      WHERE
        question_likes.question_id = ?
    SQL

    data.first['count']
  end

  def self.likers_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        question_likes
      JOIN
        users ON question_likes.user_id = users.id
      WHERE
        question_likes.question_id = ?
    SQL

    return nil if data.empty?
    data.map {|datum| User.new(datum)}
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM question_likes
      WHERE id = ?
    SQL
    return nil if data.empty?
    QuestionLike.new(data.first)
  end
end
