INSERT INTO players (username, password, name,is_admin,team_id) VALUES
    ('ProduciveExecutioner','test123','Peter Hornberger',false,1),
    ('Lemonator','test123','Elizabeth Lemon',true,2),
    ('SilverPanther','princeton4ever','Jack Donaghy',true,3),
    ('IGOTEGOTWHATUGOT','angie123','Tracy Jordan',false,4);

INSERT INTO tournaments (name,start_date,end_date,start_time,end_time,location,admin_id) VALUES
    ('30 Rock Annual Championships','2015-01-25','2015-01-25','12:00:00','23:00:00','30 Rockefeller Plaza, New York, NY 10112',3),
    ('The REAL Championships that dont suck!','2015-01-26','2015-01-26','00:00:00','06:00:00','The Writers Room',2);

INSERT INTO matches (is_tournament_match,tournament_id,score_multiplier) VALUES
    (true,1,1.5),
    (true,1,1.5),
    (true,1,1.5),
    (true,1,1.5);

INSERT INTO matches (is_tournament_match) VALUES
    (false);

INSERT INTO teams (match_id) VALUES
    (1),
    (2),
    (3),
    (4),
    (5);
