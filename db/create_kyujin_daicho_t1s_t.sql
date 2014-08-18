drop table if exists kyujin_daicho_t1s;
create table kyujin_daicho_t1s(
       id                      INT not null auto_increment,
       kyujin_uketsukes_id      INT not null,
       uketsuke_pdfs_id         INT not null,

        CONSTRAINT fk_kjdaicho_kjuketsuke FOREIGN KEY (kyujin_uketsukes_id) REFERENCES kyujin_uketsukes(id) ON DELETE CASCADE ON UPDATE CASCADE,
        constraint fk_kjdaicho_kukepdf foreign key (uketsuke_pdfs_id) references uketsuke_pdfs(id) ON DELETE CASCADE ON UPDATE CASCADE,


#from kyujin_uketsukes(
#      uketsuke_nen            INT,
#      uketuke_date	varchar(16),
#      uketuke_bango	INT,
#      tenkin	             INT,
#      koutai	             INT,
#      kihonkyu	             INT,
#      kijunnai_tingin	INT,
#      kei	                        INT,
#      kyujin_sosu	        INT,
#      sintai	        INT,
#      kengaku	        INT,
#      bikou	        varchar(128),

#      shokushu_bango	INT,
#      shokushu_mei	varchar(128),
#      shokugyo_code	INT,
#      kikai	        varchar(4),
#      denki	        varchar(4),
#      joho	        varchar(4),
#      kouka	        varchar(4),
#      kenchiku	        varchar(4),
#      kigyo_bango	INT,
#from  kigyo_infos(
#      sangyo_code	INT,
#      jugyoinsu	                INT,
#      sihon_oku	                INT,
#      sihon_senman	INT,
#from  kigyo_daichos(
#       jigyosho_mei1    varchar(128), 
#       jigyosho_mei2    varchar(64),
#       shozaichi                varchar(32),
#       seisan_hinmoku  varchar(256),
#from uketsuke_pdfs(
#        pdf_file_name       varchar(32),

        primary key (id)
);
