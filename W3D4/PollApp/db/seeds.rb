# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = ('a'..'z').map {|sn| User.create!(user_name: "#{sn} user")}

polls = (1..2).map {|poll| Poll.create!(title: poll.to_s, user_id: users.first.id)}

poll1_questions = ('a'..'f').map {|q| Question.create!(poll_id: polls[0].id, text: "Do you like #{q}?")}
poll2_questions = ('A'..'F').map {|q| Question.create!(poll_id: polls[1].id, text: "Do you like #{q}?")}

poll1_answers = poll1_questions.map do |q|
  [AnswerChoice.create!(question_id: q.id, text: 'yes'),
    AnswerChoice.create!(question_id: q.id, text: 'no')]
end

poll2_answers = poll1_questions.map do |q|
  [AnswerChoice.create!(question_id: q.id, text: 'yes'),
    AnswerChoice.create!(question_id: q.id, text: 'no')]
end

poll1_answers.each do |answer|
  Response.create!(user_id: users[1].id, answer_choice_id: answer[0].id)
  Response.create!(user_id: users[2].id, answer_choice_id: answer[1].id)
  Response.create!(user_id: users[3].id, answer_choice_id: answer[1].id)
  Response.create!(user_id: users[4].id, answer_choice_id: answer[1].id)
  Response.create!(user_id: users[5].id, answer_choice_id: answer[0].id)
end

poll2_answers.each do |answer|
  Response.create!(user_id: users[1].id, answer_choice_id: answer[1].id)
  Response.create!(user_id: users[2].id, answer_choice_id: answer[0].id)
  Response.create!(user_id: users[3].id, answer_choice_id: answer[0].id)
  Response.create!(user_id: users[4].id, answer_choice_id: answer[0].id)
end
