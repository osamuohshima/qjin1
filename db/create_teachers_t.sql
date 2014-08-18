DROP TABLE if EXISTS teachers;
CREATE TABLE  teachers (
	  id			INT				NOT NULL auto_increment,
      name_sei    	VARCHAR(40) NOT NULL,     
      name_mei		VARCHAR(40) NOT NULL,
      sex  			INT	,
	    kyoka		VARCHAR(40) NOT NULL,
	    tennyu_nen	INT,
	    tenshutsu_nen  INT,
	    user_id		INT   NOT NULL,
			primary key (id)
);


