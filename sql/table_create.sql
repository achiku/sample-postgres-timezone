CREATE TABLE t1 (
  id serial unique
  ,desc text
  ,tz timestamp with time zone not null
  ,notz timestamp without time zone not null
);

CREATE TABLE t2 (
  id serial unique
  ,desc text
  ,tz timestamp with time zone not null
  ,notz timestamp without time zone not null
);
