DROP TABLE if EXISTS users;
CREATE TABLE  users (
	  id			INT				NOT NULL auto_increment,
      login		VARCHAR(40)			NOT NULL,
      name    	VARCHAR(80),     
      email		VARCHAR(100),
   crypted_password   varchar(40)  NOT NULL,  
   salt              varchar(40),  
   created_at          datetime,
   updated_at          datetime,
   remember_token      varchar(80),
   remember_token_expires_at datetime,
  group_id		INT   NOT NULL,
			primary key (id)
);

