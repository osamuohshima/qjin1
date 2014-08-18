drop table if exists kigyo_homons;
create table kigyo_homons(
	   id           	INT not null auto_increment,
       kigyo_bango     INT not null,
       jigyosho_mei1   varchar(128),
       jigyosho_mei2   varchar(64),
	   senmon_ka	   varchar(1),
       kyujin_joko     varchar(256),
       ob_yosu         varchar(256),
       visiting_date	datetime,
	   primary key (id)
);
