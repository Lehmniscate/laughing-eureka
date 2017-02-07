class Question
  attr_reader :id
  attr_accessor :title, :body, :author_id
  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def self.find_by_body(text)
    t = '%' + text + '%'
    data = QuestionsDatabase.instance.execute(<<-SQL, t)
      SELECT *
      FROM questions
      WHERE questions.body LIKE ?
    SQL
    return nil if data.empty?
    data.map { |datum| Question.new(datum) }
  end

  def self.find_by_title(text)
    t = '%' + text + '%'
    data = QuestionsDatabase.instance.execute(<<-SQL, t)
      SELECT *
      FROM questions
      WHERE questions.title LIKE ?
    SQL
    return nil if data.empty?
    data.map { |datum| Question.new(datum) }
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def replies
    Reply.find_by_subject_id(@id)
  end

  def author
    User.find_by_id(@author_id)
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM questions
      WHERE id = ?
    SQL
    return nil if data.empty?
    Question.new(data.first)
  end

  def self.find_by_author_id(author_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT *
      FROM questions
      WHERE author_id = ?
    SQL
    return nil if data.empty?
    data.map { |datum| Question.new(datum) }
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def save
    if @id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @author_id)
        INSERT INTO
          users (title, body, author_id)
        VALUES
          (?, ?, ?)
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @author_id, @id)
        UPDATE
          users
        SET
          title = ?, body = ?, author_id = ?
        WHERE
          id = ?
      SQL
    end
  end
end
