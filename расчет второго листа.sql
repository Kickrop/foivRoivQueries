--https://docs.google.com/spreadsheets/d/e/2PACX-1vRYAkVtEbvSIrLl1SSPYcdJsJ5iOZX_trpEL8kd-A0d2JhJDL_eAzt_AuiS7jrdi4XlNOgL7EEhk7Fs/pub?gid=0&single=true&output=csv
with data as 
(
select *
from
 get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vRYAkVtEbvSIrLl1SSPYcdJsJ5iOZX_trpEL8kd-A0d2JhJDL_eAzt_AuiS7jrdi4XlNOgL7EEhk7Fs/pub?gid=0&single=true&output=csv'::text) a(file_name text, foiv text, str_number integer, x1 text, x2 text, x3 text, x4 text, x5 text, x6 text, x7 text, x8 text, x9 text, x10 text)
)

	select foiv, x1_yes, x1_no, x1_all, 
	       round((x1_yes::float / x1_all::float * 100)::numeric, 2) x1_yes_percent,
	       round((x1_no::float / x1_all::float * 100)::numeric, 2) x1_no_percent
	from
		(
		select foiv,
		count(case when x1 = '1' then x1 end) x1_yes,
		count(case when x1 = '2' then x1 end) x1_no,
		count(x1) x1_all
		from data
		group by foiv
		) count_data
	order by foiv
--


	
	select foiv, count(x1) x1_2
	from data
	where x1 = '1'--foiv <> ''
	group by foiv
	) data
	where x1_2 = '2'
	join
	select foiv fo2, count(data.x1) x1_1
	from data
	where foiv <> '' and x1 = '1'
	group by foiv
	on (data.fo1 = data.fo2)


	
	union all
	select foiv, count(data.x1) x1_1
	from data
	where foiv <> '' and x1 = '1'
	group by foiv
	--) data_total
	union all
	select foiv, count(data.x1) x1_2
	from data
	where foiv <> '' and x1 = '2'
	group by foiv
	order by foiv
