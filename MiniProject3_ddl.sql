create database baseball;
use baseball;

create table salaries
	(team		varchar(30),
	 player		varchar(50),
	 salary		numeric(10,0),
     pos		varchar(20),
	 primary key (team, player, pos)
	);
