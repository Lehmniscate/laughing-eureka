require_relative "modelbase"

class Question < ModelBase
  TABLE = "questions"

  attr_reader :id
  attr_accessor :title, :body, :author_id

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
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

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

end
