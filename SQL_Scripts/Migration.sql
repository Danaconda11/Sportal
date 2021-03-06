/* This schema is designed for the sport of hockey. */
DROP DATABASE IF EXISTS `sportal`;
CREATE DATABASE `sportal`;
USE `sportal`;

DROP TABLE IF EXISTS `Player_Stats`;
DROP TABLE IF EXISTS `Games`;
DROP TABLE IF EXISTS `Away_Team_Games`;
DROP TABLE IF EXISTS `Home_Team_Games`;
DROP TABLE IF EXISTS `Team_Players`;
DROP TABLE IF EXISTS `Season_Points`;
DROP TABLE IF EXISTS `Seasons`;
DROP TABLE IF EXISTS `Players`;
DROP TABLE IF EXISTS `Teams`;

CREATE TABLE `Teams` (
	`team_id` int(11) NOT NULL AUTO_INCREMENT,
	`team_name` varchar(512) NOT NULL,
	PRIMARY KEY (`team_id`)
);

CREATE TABLE `Players` (
	`player_id` int(11) NOT NULL AUTO_INCREMENT,
	`first_name` varchar(512) NOT NULL,
	`last_name` varchar(512) NOT NULL,
	PRIMARY KEY (`player_id`)
);

CREATE TABLE `Seasons` (
	`season_id` int(11) NOT NULL AUTO_INCREMENT,
	`season_start_year` year NOT NULL,
	`season_end_year` year NOT NULL,
	PRIMARY KEY (`season_id`)
);

CREATE TABLE `Season_Points` (
    `season_points_id` int(11) NOT NULL AUTO_INCREMENT,
	`season_id` int(11) NOT NULL,
	`team_id` int(11) NOT NULL,
	`wins` int(11) NOT NULL,
	`loses` int(11) NOT NULL,
	`ties` int(11) NOT NULL,
	PRIMARY KEY (`season_points_id`),
	KEY `Season_Points_KEY_season_id` (`season_id`),
	KEY `Season_Points_KEY_team_id` (`team_id`),
	CONSTRAINT `Season_Points_KEY_season_id` FOREIGN KEY (`season_id`) REFERENCES `Seasons` (`season_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT `Season_Points_KEY_team_id` FOREIGN KEY (`team_id`) REFERENCES `Teams` (`team_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
	
CREATE TABLE `Team_Players` (
	`team_players_id` int(11) NOT NULL AUTO_INCREMENT,
	`season_id` int(11) NOT NULL,
	`team_id` int(11) DEFAULT NULL,
	`player_id` int(11) NOT NULL,
	`jersey` int(11) DEFAULT NULL,
	PRIMARY KEY (`team_players_id`),
	KEY `Team_Players_KEY_season_id` (`season_id`),
	KEY `Team_Players_KEY_team_id` (`team_id`),
	KEY `Team_Players_KEY_player_id` (`player_id`),
	CONSTRAINT `Team_Players_KEY_season_id` FOREIGN KEY (`season_id`) REFERENCES `Seasons` (`season_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT `Team_Players_KEY_team_id` FOREIGN KEY (`team_id`) REFERENCES `Teams` (`team_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT `Team_Players_KEY_player_id` FOREIGN KEY (`player_id`) REFERENCES `Players` (`player_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `Home_Team_Games` (
	`home_team_game_id` int(11) NOT NULL AUTO_INCREMENT,
	`team_id` int(11) NOT NULL,
	PRIMARY KEY (`home_team_game_id`),
	KEY `Home_Team_Games_KEY_team_id` (`team_id`),
	CONSTRAINT `Home_Team_Games_KEY_team_id` FOREIGN KEY (`team_id`) REFERENCES `Teams` (`team_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
 );

CREATE TABLE `Away_Team_Games` (
	`away_team_game_id` int(11) NOT NULL AUTO_INCREMENT,
	`team_id` int(11) NOT NULL,
	PRIMARY KEY (`away_team_game_id`),
	KEY `Away_Team_Games_KEY_team_id` (`team_id`),
	CONSTRAINT `Away_Team_Games_KEY_team_id` FOREIGN KEY (`team_id`) REFERENCES `Teams` (`team_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
 );

CREATE TABLE `Games` (
	`game_id` int(11) NOT NULL AUTO_INCREMENT,
	`season_id` int(11) NOT NULL,
	`home_team_game_id` int(11) NOT NULL,
	`away_team_game_id` int(11) NOT NULL,
	`game_datetime` datetime NOT NULL,
	PRIMARY KEY (`game_id`),
	KEY `Games_KEY_season_id` (`season_id`),
	KEY `Games_KEY_home_team_game_id` (`home_team_game_id`),
	KEY `Games_KEY_away_team_game_id` (`away_team_game_id`),
	CONSTRAINT `Games_KEY_season_id` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`season_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT `Games_KEY_home_team_game_id` FOREIGN KEY (`home_team_game_id`) REFERENCES `Home_Team_Games` (`home_team_game_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT `Games_KEY_away_team_game_id` FOREIGN KEY (`away_team_game_id`) REFERENCES `Away_Team_Games` (`away_team_game_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `Player_Stats` (
	`player_stats_id` int(11) NOT NULL AUTO_INCREMENT,
	`player_id` int(11) NOT NULL,
	`game_id` int(11) NOT NULL,
	`team_played_for` int(11) NOT NULL,
	`goals` int(11) NOT NULL,
	`assists` int(11) NOT NULL,
	`penalty_minutes` TIME NOT NULL,
	PRIMARY KEY (`player_stats_id`),
	KEY `Player_Stats_KEY_player_id` (`player_id`),
	KEY `Player_Stats_KEY_game_id` (`game_id`),
	KEY `Player_Stats_KEY_team_played_for` (`team_played_for`),
	CONSTRAINT `Player_Stats_KEY_player_id` FOREIGN KEY (`player_id`) REFERENCES `Players` (`player_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT `Player_Stats_KEY_game_id` FOREIGN KEY (`game_id`) REFERENCES `Games` (`game_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT `Player_Stats_KEY_team_played_for` FOREIGN KEY (`team_played_for`) REFERENCES `Teams` (`team_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

DELIMITER $$

CREATE PROCEDURE `GetGameScore`(
    IN GameID int(11)
)
BEGIN
    SELECT T2.Game_Datetime, Home_Team_ID, Home_Team_Name, IFNULL(Home_Goals, 0) AS Home_Goals, Away_Team_ID, Away_Team_Name, IFNULL(Away_Goals, 0) AS Away_Goals FROM
    (SELECT a.Game_ID, a.Game_Datetime, c.Team_ID AS Home_Team_ID, c.Team_Name AS Home_Team_Name, SUM(b.Goals) AS Home_Goals
    FROM Games a, Player_Stats b, Teams c, Home_Team_Games d
    WHERE a.Game_ID = GameID AND a.Game_ID = b.Game_ID AND b.Team_Played_For = c.Team_ID AND c.Team_ID = d.Team_ID AND a.Home_Team_Game_ID = d.Home_Team_Game_ID) AS T1
    INNER JOIN
    (SELECT a.Game_ID, a.Game_Datetime, c.Team_ID AS Away_Team_ID, c.Team_Name AS Away_Team_Name, SUM(b.Goals) AS Away_Goals
    FROM Games a, Player_Stats b, Teams c, Away_Team_Games d
    WHERE a.Game_ID = GameID AND a.Game_ID = b.Game_ID AND b.Team_Played_For = c.Team_ID AND c.Team_ID = d.Team_ID AND a.Away_Team_Game_ID = d.Away_Team_Game_ID) AS T2
    ON T1.Game_ID = T2.Game_ID;
END$$

CREATE PROCEDURE `GetGameScores`()
BEGIN
    DECLARE done int DEFAULT 0;
    DECLARE G_ID, H_ID, H_GOALS, A_ID, A_GOALS int(11);
    DECLARE H_NAME, A_NAME varchar(512);
    DECLARE DT datetime;
    DECLARE cur CURSOR FOR
    SELECT DISTINCT Game_ID
    FROM Games;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    DROP TEMPORARY TABLE IF EXISTS `TMP`;
    CREATE TEMPORARY TABLE TMP(
        `game_id` int(11),
        `game_datetime` datetime,
        `home_team_id` int(11),
        `home_team_name` varchar(512),
        `home_goals` int(11),
        `away_team_id` int(11),
        `away_team_name` varchar(512),
        `away_goals` int(11)
    );
    OPEN cur;
    rdloop: LOOP
        FETCH cur INTO G_ID;
        IF done = 1 THEN
            LEAVE rdloop;
        END IF;
        INSERT INTO TMP (game_id, game_datetime, home_team_id, home_team_name, home_goals, away_team_id, away_team_name, away_goals)
        SELECT T1.Game_ID, T1.Game_Datetime, T1.Home_Team_ID, T1.Home_Team_Name, IFNULL(T1.Home_Goals, 0) AS Home_Goals, T2.Away_Team_ID, T2.Away_Team_Name, IFNULL(T2.Away_Goals, 0) AS Away_Goals
        FROM
        ((SELECT a.Game_ID, a.Game_Datetime, c.Team_ID AS Home_Team_ID, c.Team_Name AS Home_Team_Name, SUM(b.Goals) AS Home_Goals
        FROM Games a, Player_Stats b, Teams c, Home_Team_Games d
        WHERE a.Game_ID = G_ID AND a.Game_ID = b.Game_ID AND b.Team_Played_For = c.Team_ID AND c.Team_ID = d.Team_ID AND a.Home_Team_Game_ID = d.Home_Team_Game_ID) AS T1
        INNER JOIN
        (SELECT a.Game_ID, a.Game_Datetime, c.Team_ID AS Away_Team_ID, c.Team_Name AS Away_Team_Name, SUM(b.Goals) AS Away_Goals
        FROM Games a, Player_Stats b, Teams c, Away_Team_Games d
        WHERE a.Game_ID = G_ID AND a.Game_ID = b.Game_ID AND b.Team_Played_For = c.Team_ID AND c.Team_ID = d.Team_ID AND a.Away_Team_Game_ID = d.Away_Team_Game_ID) AS T2
        ON T1.Game_ID = T2.Game_ID);
    END LOOP;
    CLOSE cur;
    SELECT Game_ID, Game_Datetime, Home_Team_ID, Home_Team_Name, Home_Goals, Away_Team_ID, Away_Team_Name, Away_Goals FROM TMP;
END$$

CREATE PROCEDURE `GetGameStatsFORAwayTeam`(
    IN GameID int(11)
)
BEGIN
    SELECT d.Player_ID, b.Team_Played_For, d.First_Name, d.Last_Name, e.Jersey, b.Goals, b.Assists, b.Penalty_Minutes 
    FROM Games a, Player_Stats b, Teams c, Players d, Team_Players e, Away_Team_Games f
    WHERE b.Player_ID = d.Player_ID AND a.Game_ID = GameID AND b.Game_ID = a.Game_ID AND b.Team_Played_For = c.Team_ID AND d.Player_ID = e.Player_ID AND c.Team_ID = f.Team_ID AND a.Away_Team_Game_ID = f.Away_Team_Game_ID;
END$$

CREATE PROCEDURE `GetGameStatsFORHomeTeam`(
    IN GameID int(11)
)
BEGIN
    SELECT d.Player_ID, b.Team_Played_For, d.First_Name, d.Last_Name, e.Jersey, b.Goals, b.Assists, b.Penalty_Minutes 
    FROM Games a, Player_Stats b, Teams c, Players d, Team_Players e, Home_Team_Games f
    WHERE b.Player_ID = d.Player_ID AND a.Game_ID = GameID AND b.Game_ID = a.Game_ID AND b.Team_Played_For = c.Team_ID AND d.Player_ID = e.Player_ID AND c.Team_ID = f.Team_ID AND a.Home_Team_Game_ID = f.Home_Team_Game_ID;
END$$

CREATE PROCEDURE `GetPlayerStatsForEachGame`(
    IN PlayerID int(11)
)
BEGIN
    SELECT a.Game_ID, a.Game_Datetime, c.Team_Name, b.Goals, b.Assists, b.Penalty_minutes 
    FROM Games a, Player_Stats b, Teams c
    WHERE b.Player_ID = PlayerID AND b.Game_ID = a.Game_ID AND b.Team_Played_For = c.Team_ID;
END$$

CREATE PROCEDURE `GetPlayerStats`()
BEGIN
    DECLARE done int DEFAULT 0;
    DECLARE P_ID, G, A int(11);
    DECLARE FST, LST varchar(512);
    DECLARE PM time;
    DECLARE cur CURSOR FOR 
    (SELECT DISTINCT a.Player_ID, a.First_Name, a.Last_Name
    FROM Players a, Team_Players b
    WHERE a.Player_ID = b.Player_ID AND b.Team_ID IS NULL)
    UNION ALL 
    (SELECT DISTINCT a.Player_ID, a.First_Name, a.Last_Name
    FROM Players a, Team_Players b, Teams c
    WHERE a.Player_ID = b.Player_ID AND b.Team_ID = c.Team_ID);
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    DROP TEMPORARY TABLE IF EXISTS `TMP`;
    CREATE TEMPORARY TABLE TMP(
        `player_id` int(11),
        `first_name` varchar(512),
        `last_name` varchar(512),
        `goals` int(11),
        `assists` int(11),
        `penalty_minutes` time
    );
    OPEN cur;
    rdloop: LOOP
        FETCH cur INTO P_ID, FST, LST;
        IF done = 1 THEN
            LEAVE rdloop;
        END IF;
        SELECT DISTINCT COALESCE(SUM(b.Goals),0), COALESCE(SUM(b.Assists),0), COALESCE(SEC_TO_TIME(SUM(TIME_TO_SEC(b.Penalty_Minutes))),0)
        INTO @G, @A, @PM
        FROM Games a, Player_Stats b, Teams c, Players d, Team_Players e 
        WHERE b.Player_ID = d.Player_ID AND b.Game_ID = a.Game_ID AND b.Team_Played_For = c.Team_ID AND d.Player_ID = e.Player_ID AND d.Player_ID = P_ID AND a.Season_ID = e.Season_ID;     
        INSERT TMP VALUES (P_ID,FST,LST,@G,@A,@PM);
    END LOOP;
    CLOSE cur;
    SELECT Player_ID, First_Name, Last_Name, Goals, Assists, Penalty_Minutes FROM TMP;
END$$

CREATE PROCEDURE `GetPlayerStatsBYSeason`(
    IN SeasonID int(11)
)
BEGIN
    DECLARE done int DEFAULT 0;
    DECLARE P_ID, T_ID, G, A int(11);
    DECLARE FST, LST, TM varchar(512);
    DECLARE PM time;
    DECLARE cur CURSOR FOR 
    (SELECT DISTINCT a.Player_ID, a.First_Name, a.Last_Name, NULL AS Team_ID, 'Spares'
    FROM Players a, Team_Players b
    WHERE a.Player_ID = b.Player_ID AND b.Season_ID = SeasonID AND b.Team_ID IS NULL)
    UNION ALL 
    (SELECT DISTINCT a.Player_ID, a.First_Name, a.Last_Name, c.Team_ID, c.Team_Name
    FROM Players a, Team_Players b, Teams c
    WHERE a.Player_ID = b.Player_ID AND b.Season_ID = SeasonID AND b.Team_ID = c.Team_ID);
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    DROP TABLE IF EXISTS `TMP`;
    CREATE TEMPORARY TABLE TMP(
        `player_id` int(11),
        `first_name` varchar(512),
        `last_name` varchar(512),
        `team_id` int(11),
        `team_name` varchar(512),
        `goals` int(11),
        `assists` int(11),
        `penalty_minutes` time
    );
    OPEN cur;
    rdloop: LOOP
        FETCH cur INTO P_ID, FST, LST, T_ID, TM;
        IF done = 1 THEN
            LEAVE rdloop;
        END IF;
        SELECT DISTINCT COALESCE(SUM(b.Goals),0), COALESCE(SUM(b.Assists),0), COALESCE(SEC_TO_TIME(SUM(TIME_TO_SEC(b.Penalty_Minutes))),0)
        INTO @G, @A, @PM
        FROM Games a, Player_Stats b, Teams c, Players d, Team_Players e 
        WHERE b.Player_ID = d.Player_ID AND b.Game_ID = a.Game_ID AND b.Team_Played_For = c.Team_ID AND d.Player_ID = e.Player_ID AND d.Player_ID = P_ID AND a.Season_ID = e.Season_ID AND a.Season_ID = SeasonID;     
        INSERT TMP VALUES (P_ID,FST,LST,T_ID,TM,@G,@A,@PM);
    END LOOP;
    CLOSE cur;
    SELECT Player_ID, First_Name, Last_Name, Team_ID, Team_Name, Goals, Assists, Penalty_Minutes FROM TMP;
END$$

CREATE PROCEDURE `GetPlayerStatsBYSeasonANDTeam`(
    IN SeasonID int(11),
    IN TeamID int(11)
)
BEGIN
    DECLARE done int DEFAULT 0;
    DECLARE P_ID, J, G, A int(11);
    DECLARE FST, LST varchar(512);
    DECLARE PM time;
    DECLARE cur CURSOR FOR 
    SELECT DISTINCT a.Player_ID, b.Jersey, a.First_Name, a.Last_Name
    FROM Players a, Team_Players b, Teams c
    WHERE a.Player_ID = b.Player_ID AND b.Season_ID = SeasonID AND b.Team_ID = c.Team_ID AND b.Team_ID = TeamID;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    DROP TABLE IF EXISTS `TMP`;
    CREATE TEMPORARY TABLE TMP(
        `player_id` int(11),
        `jersey` int(11),
        `first_name` varchar(512),
        `last_name` varchar(512),
        `goals` int(11),
        `assists` int(11),
        `penalty_minutes` time
    );
    OPEN cur;
    rdloop: LOOP
        FETCH cur INTO P_ID, J, FST, LST;
        IF done = 1 THEN
            LEAVE rdloop;
        END IF;
        SELECT DISTINCT COALESCE(SUM(b.Goals),0), COALESCE(SUM(b.Assists),0), COALESCE(SEC_TO_TIME(SUM(TIME_TO_SEC(b.Penalty_Minutes))),0)
        INTO @G, @A, @PM
        FROM Games a, Player_Stats b, Teams c, Players d, Team_Players e 
        WHERE b.Player_ID = d.Player_ID AND b.Game_ID = a.Game_ID AND b.Team_Played_For = c.Team_ID AND c.Team_ID = TeamID AND d.Player_ID = e.Player_ID AND d.Player_ID = P_ID AND a.Season_ID = e.Season_ID AND a.Season_ID = SeasonID;     
        INSERT TMP VALUES (P_ID,J,FST,LST,@G,@A,@PM);
    END LOOP;
    CLOSE cur;
    SELECT Player_ID, First_Name, Last_Name, Goals, Assists, Penalty_Minutes FROM TMP;
END$$

CREATE PROCEDURE `GetPlayerStatsBYSeasonFORSpares`(
    IN SeasonID int(11)
)
BEGIN
    DECLARE done int DEFAULT 0;
    DECLARE P_ID, G, A int(11);
    DECLARE FST, LST varchar(512);
    DECLARE PM time;
    DECLARE cur CURSOR FOR 
    SELECT DISTINCT a.Player_ID, a.First_Name, a.Last_Name
    FROM Players a, Team_Players b, Teams c
    WHERE a.Player_ID = b.Player_ID AND b.Season_ID = SeasonID AND b.Team_ID IS NULL;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    DROP TABLE IF EXISTS `TMP`;
    CREATE TEMPORARY TABLE TMP(
        `player_id` int(11),
        `first_name` varchar(512),
        `last_name` varchar(512),
        `goals` int(11),
        `assists` int(11),
        `penalty_minutes` time
    );
    OPEN cur;
    rdloop: LOOP
        FETCH cur INTO P_ID, FST, LST;
        IF done = 1 THEN
            LEAVE rdloop;
        END IF;
        SELECT DISTINCT COALESCE(SUM(b.Goals),0), COALESCE(SUM(b.Assists),0), COALESCE(SEC_TO_TIME(SUM(TIME_TO_SEC(b.Penalty_Minutes))),0)
        INTO @G, @A, @PM
        FROM Games a, Player_Stats b, Teams c, Players d, Team_Players e 
        WHERE b.Player_ID = d.Player_ID AND b.Game_ID = a.Game_ID AND b.Team_Played_For = c.Team_ID AND d.Player_ID = e.Player_ID AND d.Player_ID = P_ID AND a.Season_ID = e.Season_ID AND a.Season_ID = SeasonID;     
        INSERT TMP VALUES (P_ID,FST,LST,@G,@A,@PM);
    END LOOP;
    CLOSE cur;
    SELECT Player_ID, First_Name, Last_Name, Goals, Assists, Penalty_Minutes FROM TMP;
END$$
												       
CREATE PROCEDURE `GetTeamStats`(
    IN SeasonID int(11),
    IN TeamID int(11)
)
BEGIN
    SELECT DISTINCT a.Team_ID, a.Team_Name, c.Wins, c.Loses, c.Ties
    FROM Teams a, Seasons b, Season_Points c
    WHERE a.Team_ID = TeamID AND b.Season_ID = SeasonID AND a.Team_ID = c.Team_ID AND b.Season_ID = c.Season_ID LIMIT 1;
END$$
 
DELIMITER ;
