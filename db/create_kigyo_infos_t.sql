drop table if exists zips;
create table zips(
        id                        INT not null auto_increment,
      zip	varchar(7),
      prefecture_id	INT,
      city	                varchar(64),
      town	                varchar(254),
        primary key (id)
);
