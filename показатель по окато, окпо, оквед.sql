select
r1.id, 
okato,
okved,
okpo,
--r1.str_number r1_str_number, 
r1.zn3 r1zn3, 
r1.zn4 r1zn4, 
r1.zn5 r1zn5, 
r1.zn6 r1zn6, 
r1.zn7 r1zn7, 
r1.zn8 r1zn8,
r2.zn3 r2zn3,
r2.zn4 r2zn4,
--r5.str_number r5_str_number,
--r5.zn5 r5zn5
sum(case when r5.str_number = '501' then r5.zn5 end) as "r5zn5_501",
sum(case when r5.str_number = '502' then r5.zn5 end) as "r5zn5_502",
sum(case when r5.str_number = '503' then r5.zn5 end) as "r5zn5_503",
sum(case when r5.str_number = '514' then r5.zn5 end) as "r5zn5_514"
from 
(
	--select * 
	(
	select *
	from
	get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vTeRYufipLt2dSGVs1Dfdj0QFzRJPAHvckpQb78tppzlEjN2_wLN8p9RybJMaasWeewVzIeW4grLSQv/pub?gid=0&single=true&output=csv'::text) a(id text, str_number text, zn3 bigint, zn4 bigint, zn5 bigint, zn6 bigint, zn7 bigint, zn8 bigint)
	where str_number = '101'
	) r1
-- 	select *
-- 	from r1
 	join
	(
	select *
	from
	get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vTeRYufipLt2dSGVs1Dfdj0QFzRJPAHvckpQb78tppzlEjN2_wLN8p9RybJMaasWeewVzIeW4grLSQv/pub?gid=2035550703&single=true&output=csv'::text) a(id text, str_number text, zn3 bigint, zn4 bigint, zn5 bigint, zn6 bigint)
	where str_number in ('501', '502', '503', '514')
	) r5
	on (r1.id = r5.id)
	join
	(
	select *
	from
	get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vTeRYufipLt2dSGVs1Dfdj0QFzRJPAHvckpQb78tppzlEjN2_wLN8p9RybJMaasWeewVzIeW4grLSQv/pub?gid=637383244&single=true&output=csv'::text) a(id text, str_number text, zn3 text, zn4 text)
	where str_number = '234' 
	) r2
	on (r1.id = r2.id)
		join
	(
	select *
	from
	get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vTeRYufipLt2dSGVs1Dfdj0QFzRJPAHvckpQb78tppzlEjN2_wLN8p9RybJMaasWeewVzIeW4grLSQv/pub?gid=367400508&single=true&output=csv'::text) a(id text, okpo text, okved text, okato text)
	--where str_number = '234' 
	) titul
	on (r1.id = titul.id)
) 
group by 
r1.id, 
okato,
okved,
okpo,
--r1_str_number, 
r1zn3, 
r1zn4, 
r1zn5, 
r1zn6, 
r1zn7, 
r1zn8,
r2zn3,
r2zn4--,
--r5_str_number