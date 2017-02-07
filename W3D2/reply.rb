require_relative "modelbase"

class Reply < ModelBase
  TABLE = "replies"

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

end
