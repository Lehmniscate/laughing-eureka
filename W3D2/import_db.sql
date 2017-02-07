DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255),
  lname VARCHAR(255)
  );

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255),
  body TEXT,
  author_id INTEGER,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER,
  user_id INTEGER,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  subject_id INTEGER,
  author_id INTEGER,
  parent_reply_id INTEGER,
  body TEXT,


  FOREIGN KEY (subject_id) REFERENCES questions(id),
  FOREIGN KEY (author_id) REFERENCES users(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER,
  question_id INTEGER,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Dylan', 'Cheng');

INSERT INTO
  users (fname, lname)
VALUES
  ('Michael', 'Hooton');

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('Why?', 'Why you so mean?', 1);

INSERT INTO
  question_follows (question_id, user_id)
VALUES
  (1, 2);

INSERT INTO
  replies (subject_id, author_id, parent_reply_id, body)
VALUES
  (1, 2, NULL, 'I think they hate us');

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  (2, 1);
