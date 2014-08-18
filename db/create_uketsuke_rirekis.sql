drop table if exists uketsuke_rirekis;
create table uketsuke_rirekis(
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
       kigyo_daicho_id INT,
       primary key (id)
);
