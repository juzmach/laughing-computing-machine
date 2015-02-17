INSERT INTO player (username, password, player_name,is_admin) VALUES
    ('ProduciveExecutioner','test123','Peter Hornberger',false),
    ('Lemonator','test123','Elizabeth Lemon',true),
    ('SilverPanther','princeton4ever','Jack Donaghy',true),
    ('IGOTEGOTWHATUGOT','angie123','Tracy Jordan',false),
    ('Heisenberg','SayMyName','Walter White',false),
    ('SUCKITBITCH!','CapnCook','Jesse Pinkman',false),
    ('CriminalLawyer','BetterCallSaul','Saul Goodman',false),
    ('Mike','Kaylee123','Mike Ehrmantraut',false),
    ('HermanoPollo','h3rm4n0s','Gustavo Fring',false),
    ('King2Co','Respect123','Tuco Salamanca',false);

INSERT INTO team (team_name,player_one_id,player_two_id) VALUES
    ('The Playahs',3,4),
    ('The Nerds',1,2),
    ('The Cooks',5,6),
    ('The Problem Solvers',7,8),
    ('HermanoPollo',9,null),
    ('King2Co',10,null);

INSERT INTO tournament (tournament_name,start_date,start_time,end_date,end_time,location,admin_id) VALUES
    ('30 Rock Annual Championships','2015-03-25','12:00:00','2015-03-25','23:00:00','30 Rockefeller Plaza, New York, NY 10112',3),
    ('The REAL Championships that dont suck!','2015-03-26','00:00:00','2015-03-26','06:00:00','The Writers Room',2);

INSERT INTO match (is_tournament_match,tournament_id,score_multiplier,team_a_id,team_b_id,match_date,status) VALUES
    (true,1,1.5,1,2,'2015-03-25','Confirmed'),
    (true,1,1.5,3,4,'2015-03-25','Confirmed'),
    (true,1,1.5,1,4,'2015-03-25','Confirmed'),
    (true,1,1.5,2,3,'2015-03-25','Confirmed'),
    (false,1,1.0,5,6,'2015-02-02','Confirmed');

UPDATE match SET
    team_a_score = 8,
    team_b_score = 0,
    status = 'Completed'
    WHERE match_id = 5;
