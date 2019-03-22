select 
sub_name,
str_num, x1_yes, x1_no, round(x1_yes::numeric/x1_total::numeric*100, 2) x1_yes_cut, round(x1_no::numeric/x1_total::numeric*100,2) x1_no_cut, x1_total
from (
	select
	--distinct titul.id,
	sub_name,
	str_num,
	count(case when x1 = '1' then x1 end) x1_yes,
	count(case when x1::int = 2 or x1 is null then 2 end) x1_no,
	count(case when x1::int = 2 or x1::int = 1 or x1 is null then 99 end) x1_total
	--count(case when x1 is null then 2 end) pusto,
	--count(str_num) x1_total
	from
		--with data as 
		(
		select *
		from
		 get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vTqBEet15-vvXa7M-nJhh6jG8c2wnl3E5d6YnwJkdXO1tRIGln5K-l34M_j5qYKzwXPqkayQNe0Okxa/pub?gid=0&single=true&output=csv'::text) a(id text, org_name text, org_address text, org_okogu text, sub_okato text, sub_name text, err text, rep text)
		) titul
		join
		(
		select *
		from
		get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vTqBEet15-vvXa7M-nJhh6jG8c2wnl3E5d6YnwJkdXO1tRIGln5K-l34M_j5qYKzwXPqkayQNe0Okxa/pub?gid=2111145768&single=true&output=csv'::text) a(id text, str_name text, str_num text, x1 text, x2 text)
		--where str_number in ('501', '502', '503', '514')
		) r1
		on (titul.id = r1.id)
	--where str_num = '1'
	where str_num in ('1','2','3')
	group by sub_name, str_num
) roiv
order by x1_total desc


select count(*)
from   (
	select *
	from
		get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vTqBEet15-vvXa7M-nJhh6jG8c2wnl3E5d6YnwJkdXO1tRIGln5K-l34M_j5qYKzwXPqkayQNe0Okxa/pub?gid=0&single=true&output=csv'::text) a(id text, org_name text, org_address text, org_okogu text, sub_okato text, sub_name text, err text, rep text)
	) titul
	where sub_name = 'Омская область'
--	
-- 	select foiv, x1_yes, x1_no, x1_all, 
-- 	       round((x1_yes::float / x1_all::float * 100)::numeric, 2) x1_yes_percent,
-- 	       round((x1_no::float / x1_all::float * 100)::numeric, 2) x1_no_percent
-- 	from
-- 		(
-- 		select foiv,
-- 		count(case when x1 = '1' then x1 end) x1_yes,
-- 		count(case when x1 = '2' then x1 end) x1_no,
-- 		count(x1) x1_all
-- 		from data
-- 		group by foiv
-- 		) count_data
-- 	order by foiv
select titul.id, count(case when x1 is null then 99 end) --count(str_num), count(coalesce(x1,'3'))
	from
		--with data as 
		(
		select *
		from
		 get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vTqBEet15-vvXa7M-nJhh6jG8c2wnl3E5d6YnwJkdXO1tRIGln5K-l34M_j5qYKzwXPqkayQNe0Okxa/pub?gid=0&single=true&output=csv'::text) a(id text, org_name text, org_address text, org_okogu text, sub_okato text, sub_name text, err text, rep text)
		) titul
		join
		(
		select *
		from
		get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vTqBEet15-vvXa7M-nJhh6jG8c2wnl3E5d6YnwJkdXO1tRIGln5K-l34M_j5qYKzwXPqkayQNe0Okxa/pub?gid=2111145768&single=true&output=csv'::text) a(id text, str_name text, str_num text, x1 text, x2 text)
		--where str_number in ('501', '502', '503', '514')
		) r1
		on (titul.id = r1.id)
	where str_num = '1' and sub_name = 'Омская область'
	group by titul.id, str_num