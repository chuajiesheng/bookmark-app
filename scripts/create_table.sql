CREATE TABLE users (
       id SERIAL PRIMARY KEY,
       username text NOT NULL,
       password text NOT NULL
);

CREATE TABLE bookmarks (
       id SERIAL PRIMARY KEY,
       user_id int NOT NULL,
       name text NOT NULL,
       url text NOT NULL
);
