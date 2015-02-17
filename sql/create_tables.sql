CREATE TABLE players (
    id                      serial        PRIMARY KEY,
    username                varchar(200)  NOT NULL UNIQUE,
    password                char(60)      NOT NULL,
    player_name             varchar(200)  NOT NULL,
    ranking_score           numeric       NOT NULL DEFAULT 1000.0,
    games_played            integer       NOT NULL DEFAULT 0,
    wins                    integer       NOT NULL DEFAULT 0,
    losses                  integer       NOT NULL DEFAULT 0,
    ties                    integer       NOT NULL DEFAULT 0,
    is_admin                boolean       NOT NULL DEFAULT false,
    created_at              timestamp     DEFAULT current_timestamp,
    updated_at              timestamp     DEFAULT current_timestamp
);

CREATE TABLE teams (
    id                      serial        PRIMARY KEY,
    team_name               varchar(200)  NOT NULL,
    player_one_id           integer       NOT NULL,
    player_two_id           integer,
    created_at              timestamp     DEFAULT current_timestamp,
    updated_at              timestamp     DEFAULT current_timestamp
);

CREATE TABLE tournaments (
    id                      serial        PRIMARY KEY,
    tournament_name         varchar(50)   NOT NULL UNIQUE,
    start_date              date          NOT NULL,
    start_time              time          NOT NULL,
    end_date                date          NOT NULL,
    end_time                time          NOT NULL,
    location                varchar(50),
    admin_id                integer       NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    created_at              timestamp     DEFAULT current_timestamp,
    updated_at              timestamp     DEFAULT current_timestamp
);

CREATE TABLE matches (
    id                      serial        PRIMARY KEY,
    is_tournament_match     boolean       NOT NULL DEFAULT false,
    tournament_id           integer       REFERENCES tournaments(id) ON DELETE CASCADE,
    score_multiplier        decimal       NOT NULL DEFAULT 1.0,
    team_a_id               integer       REFERENCES teams(id) ON DELETE CASCADE,
    team_b_id               integer       REFERENCES teams(id) ON DELETE CASCADE,
    team_a_score            integer       DEFAULT 0,
    team_b_score            integer       DEFAULT 0,
    status                  varchar(50)   DEFAULT 'Challenged',
    match_date              date,
    created_at              timestamp     DEFAULT current_timestamp,
    updated_at              timestamp     DEFAULT current_timestamp
);
