drop table if exists uketsuke_rireki_motos;
create table uketsuke_rireki_motos(
	id	INT	not null auto_increment,
       kigyo_bango INT not null,
       uke1999 INT,
       uke2000 INT,
       uke2001 INT,
       uke2002 INT,
       uke2003 INT,
       uke2004 INT,
       uke2005 INT,
       uke2006 INT,
       uke2007 INT,
       primary key (id)
);
