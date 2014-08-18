drop table if exists uketsuke_pdfs;
create table uketsuke_pdfs(
        id                  INT not null auto_increment,
        uketsuke_bango         INT,
        pdf_name       varchar(32),
        uketsuke_nen            INT,
        input_date	        datetime,
		shokushu_bango		INT,
		kyujin_uketsuke_id	INT,
        primary key (id)
);
