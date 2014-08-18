DROP TABLE if EXISTS teacher_nenjis;
CREATE TABLE  teacher_nenjis (
	  id			INT			NOT NULL auto_increment,
      nendo			INT			NOT NULL,
      bunsho		VARCHAR(40)	NOT NULL,
	    gakunen		INT			NOT NULL,
	    tannin_ka     INT,       # M=1, E=2, C=3, A=4, I=5
	    tannin_kumi   INT,       # A,B,nothing
	    teacher_id	INT		 	NOT NULL,
			primary key (id)
);

