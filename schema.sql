CREATE TABLE users (
  id SERIAL4 PRIMARY KEY,
  email VARCHAR(400) NOT NULL,
  password_digest VARCHAR(400) NOT NULL
);

CREATE TABLE photos (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(400) NOT NULL,
  image_url TEXT
);

CREATE TABLE comments (
  id SERIAL4 PRIMARY KEY,
  body TEXT,
  photo_id INTEGER
);

CREATE TABLE exercises (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(300) NOT NULL,
  video_url TEXT
);
