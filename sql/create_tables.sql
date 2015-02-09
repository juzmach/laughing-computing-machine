CREATE TABLE players (
    id                      serial      PRIMARY KEY,
    username                varchar(200) NOT NULL UNIQUE,
    password                char(60)     NOT NULL,
    name                    varchar(200) NOT NULL,
    ranking_score           numeric     NOT NULL DEFAULT 1000.0,
    games_played            integer     NOT NULL DEFAULT 0,
    wins                    integer     NOT NULL DEFAULT 0,
    losses                  integer     NOT NULL DEFAULT 0,
    ties                    integer     NOT NULL DEFAULT 0,
    is_admin                boolean     NOT NULL DEFAULT false,
    team_id                 integer
);

CREATE TABLE tournaments (
    id                      serial      PRIMARY KEY,
    name                    varchar(50) NOT NULL UNIQUE,
    start_date              date,
    end_date                date,
    start_time              time,
    end_time                time,
    location                varchar(50),
    admin_id                integer     NOT NULL REFERENCES players(id) ON DELETE CASCADE
);

CREATE TABLE matches (
    id                      serial      PRIMARY KEY,
    is_tournament_match     boolean     NOT NULL,
    tournament_id           integer     REFERENCES tournaments(id) ON DELETE CASCADE,
    score_multiplier        decimal     NOT NULL DEFAULT 1.0,
    team_a                  integer     REFERENCES teams(id), ON DELETE CASCADE,
    team_b                  integer     REFERENCES teams(id), ON DELETE CASCADE,
    team_a_score            integer     DEFAULT 0,
    team_b_score            integer     DEFAULT 0,
    match_date              date
);

CREATE TABLE teams (
    id                      serial      PRIMARY KEY,
    match_id                integer     REFERENCES matches(id) ON DELETE CASCADE
);
