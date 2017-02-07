class Reply

  attr_reader :id
  attr_accessor :subject_id, :author_id, :parent_reply_id, :body

  def initialize(options)
    @id = options['id']
    @subject_id = options['subject_id']
    @author_id = options['author_id']
    @parent_reply_id = options['parent_reply_id']
    @body = options['body']
  end

  def child_replies
    data = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT *
      FROM replies
      WHERE parent_reply_id = ?
    SQL
    return nil if data.empty?
    data.map { |datum| Reply.new(datum) }
  end

  def parent_reply
    Reply.find_by_id(@parent_reply_id)
  end

  def question
    Question.find_by_id(@subject_id)
  end

  def author
    User.find_by_id(@author_id)
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM replies
      WHERE id = ?
    SQL
    return nil if data.empty?
    Reply.new(data.first)
  end

  def self.find_by_author_id(author_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT *
      FROM replies
      WHERE author_id = ?
    SQL
    return nil if data.empty?
    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_subject_id(subject_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, subject_id)
      SELECT *
      FROM replies
      WHERE subject_id = ?
    SQL
    return nil if data.empty?
    data.map { |datum| Reply.new(datum) }
  end

  def save
    if @id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, @subject_id, @author_id, @parent_reply_id, @body)
        INSERT INTO
          users (subject_id, author_id, parent_reply_id, body)
        VALUES
          (?, ?, ?, ?)
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      QuestionsDatabase.instance.execute(<<-SQL, @subject_id, @author_id, @parent_reply_id, @body, @id)
        UPDATE
          users
        SET
          subject_id = ?, author_id = ?, parent_reply_id = ?, body = ?
        WHERE
          id = ?
      SQL
    end
  end

end
