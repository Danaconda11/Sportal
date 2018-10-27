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
  `team_id` int(11) DE NULL,
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
  `penalty_mins` TIME NOT NULL,
  PRIMARY KEY (`player_stats_id`),
  KEY `Player_Stats_KEY_player_id` (`player_id`),
  KEY `Player_Stats_KEY_game_id` (`game_id`),
  KEY `Player_Stats_KEY_team_played_for` (`team_played_for`),
  CONSTRAINT `Player_Stats_KEY_player_id` FOREIGN KEY (`player_id`) REFERENCES `Players` (`player_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Player_Stats_KEY_game_id` FOREIGN KEY (`game_id`) REFERENCES `Games` (`game_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Player_Stats_KEY_team_played_for` FOREIGN KEY (`team_played_for`) REFERENCES `Teams` (`team_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
