use qjin_development;
select * from kyujin_uketsukes as a left join kigyo_daichos as b 
  on a.kigyo_bango=b.kigyo_bango left join kigyo_infos as c 
  on b.kigyo_bango=c.kigyo_number where uketsuke_nen=2010 
  into outfile "jointable4.txt"
  fields terminated by "," optionally enclosed by '"'
  lines terminated by "\r\n";
