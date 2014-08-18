DROP TABLE if EXISTS students;
CREATE TABLE  students (
	  id			INT				NOT NULL auto_increment,
      nyugakuid		VARCHAR(40)			NOT NULL,
      name_sei    	VARCHAR(40),     
      name_mei		VARCHAR(40),
      sex  			INT		NOT NULL,
	  ka			INT		NOT NULL, # M=1, E=2, C=3, A=4, I=5
	  group_id		INT   NOT NULL,
			primary key (id)
);


