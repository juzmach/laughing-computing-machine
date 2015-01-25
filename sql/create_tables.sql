CREATE TABLE players (
    id serial PRIMARY KEY,
    username varchar(50) NOT NULL UNIQUE,
    password varchar(50) NOT NULL,
    name varchar(50) NOT NULL,
    ranking integer,
    ranking_score decimal,
    games_played integer,
    wins integer,
    losses integer,
    ties integer,
    is_admin boolean
);

CREATE TABLE tournaments (
    id serial PRIMARY KEY,
    name varchar(50) NOT NULL UNIQUE,
    start_date date,
    end_date date,
    start_time time,
    end_time time,
    location varchar(50),
    admin_id integer NOT NULL REFERENCES players(id) ON DELETE CASCADE,
);

CREATE TABLE matches (
    id serial PRIMARY KEY,
    tournament_id integer REFERENCES tournaments(id) ON DELETE CASCADE,
    score_multiplier decimal NOT NULL
);

CREATE TABLE teams (
    id serial PRIMARY KEY,
    match_id integer REFERENCES matches(id) ON DELETE CASCADE
);
