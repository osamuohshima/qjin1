drop table if exists uketsuke_rirekis;
create table  uketsuke_rirekis(
                id                      INT not null auto_increment,
                kigyo_bango     INT not null,
                uketsuke_nen    INT not null,
                uketsuke_bango          INT ,
                kigyo_daicho_id       INT,
	primary key (id)
);
