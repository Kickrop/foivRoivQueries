with data as (
		select	str_num,
			x1_yes, 
			--x1_no,
			x1_total,
			x1_pusto, 
			round(x1_yes::numeric/x1_total::numeric*100, 2) x1_yes_cut, 
			--round(x1_no::numeric/x1_total::numeric*100,2) x1_no_cut,
			round(x1_total::numeric/x1_total::numeric*100,2) x1_total_cut,
			round(x1_pusto::numeric/x1_total::numeric*100,2) x1_pusto_cut
 			,
 			x2_yes, 
-- 			x2_no,
 			x2_total,
 			x2_pusto, 
 			round(x2_yes::numeric/x2_total::numeric*100, 2) x2_yes_cut, 
-- 			round(x2_no::numeric/x2_total::numeric*100,2) x2_no_cut,
 			round(x2_total::numeric/x2_total::numeric*100,2) x2_total_cut,
 			round(x2_pusto::numeric/x2_total::numeric*100,2) x2_pusto_cut
 			,
 			x3_yes, 
-- 			x2_no,
 			x3_total,
 			x3_pusto, 
 			round(x3_yes::numeric/x3_total::numeric*100, 2) x3_yes_cut, 
-- 			round(x2_no::numeric/x2_total::numeric*100,2) x2_no_cut,
 			round(x3_total::numeric/x3_total::numeric*100,2) x3_total_cut,
 			round(x3_pusto::numeric/x3_total::numeric*100,2) x3_pusto_cut
		from (
			select
				str_num,
				count(case when x1 = '1' then x1 end) x1_yes,
-- 				count(case when x1::int = 2 then 2 end) x1_no, --or x1 is null
				count(case when x1 is null then 100 end) x1_pusto,
				count(case when x1::int = 1 or x1 is null then 99 end) x1_total
 				,
 				count(case when x2 = '1' then x2 end) x2_yes,
-- 				count(case when x2::int = 2 then 2 end) x2_no, --or x2 is null
 				count(case when x2 is null then 100 end) x2_pusto,
 				count(case when x2::int = 1 or x2 is null then 99 end) x2_total
 				,
 				count(case when x3 = '1' then x3 end) x3_yes,
-- 				count(case when x2::int = 2 then 2 end) x2_no, --or x2 is null
 				count(case when x3 is null then 100 end) x3_pusto,
 				count(case when x3::int = 1 or x3 is null then 99 end) x3_total
			from (
				select *
				from
				get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vTqBEet15-vvXa7M-nJhh6jG8c2wnl3E5d6YnwJkdXO1tRIGln5K-l34M_j5qYKzwXPqkayQNe0Okxa/pub?gid=1955114947&single=true&output=csv'::text) a(id text, str_name text, str_num text, x1 text, x2 text, x3 text, x4 text, x5 text, x6 text, x7 text, x8 text, x9 text, x10 text)
				--where str_num = '1' --in ('501', '502', '503', '514')
				) d1		
			group by str_num
			) d2
		)
-- select *
-- from data
-- select *
-- from (
	select str_num, 'Да' as val, x1_yes x1, x1_pusto, x1_total, x1_yes_cut || '%' x1_cut, x1_pusto_cut || '%' x1_pusto_cut--, x2_yes x2, x2_yes_cut x2_cut, x3_yes x3, x3_yes_cut x3_cut		
		from data
-- 	union all select str_num, 'Нет' as val,  x1_no, x1_no_cut, '2' answ_id		
-- 		from data
-- 	union all select str_num, 'Без ответа' as val,  x1_pusto, x1_pusto_cut, '3' answ_id
-- 		from data 
-- 	union all select str_num, 'Всего' as val, x1_total, x1_total_cut, '4' answ_id
-- 		from data 
--	) d3
order by str_num::int