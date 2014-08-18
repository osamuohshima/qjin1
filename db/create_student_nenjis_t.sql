DROP TABLE if EXISTS student_nenjis;
CREATE TABLE  student_nenjis (
	  id			INT			NOT NULL auto_increment,
      nendo			INT			NOT NULL,
	  gakunen		INT			NOT NULL,
      kumi			INT			NOT NULL, #A=1, B=2, No=0
	  bango			INT			NOT NULL,
	  student_id	INT		 	NOT NULL,
			primary key (id)
);

