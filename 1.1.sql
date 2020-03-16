with data as
(
select *
from
 get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vQaIeuzZURRKgYJBij3SrEPSTbFX2t8sKI2sDUUwr3ZIXraw1i2LuPBTQQtNrLcHsdPdajBL2x7i754/pub?gid=2075010081&single=true&output=csv'::text) a(a text, b text, c1 text, c2 text, c3 text, c4 text)
-- get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vQaIeuzZURRKgYJBij3SrEPSTbFX2t8sKI2sDUUwr3ZIXraw1i2LuPBTQQtNrLcHsdPdajBL2x7i754/pub?gid=1760125763&single=true&output=csv'::text) a(c0 text, c1 text, c2 text, c3 text, c4 text, c5 text) -- test
)
,
bokovik as
(
select *
from 
get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vQaIeuzZURRKgYJBij3SrEPSTbFX2t8sKI2sDUUwr3ZIXraw1i2LuPBTQQtNrLcHsdPdajBL2x7i754/pub?gid=149578648&single=true&output=csv'::text) a (g text, b text, n int)
)

select n, g, b, replace(c1, 'Я ', ''), count, round
from
(
select n, g, data_count.b, c1, data_count.count, round((data_count.count::float / data_total.count::float * 100)::numeric, 2)
from
(
	select b, count(distinct a)
	from 
	(
		select a, trim(b) as b, c1, c2, c3, c4
		from data
		where length(c1) > 1
	) data
	group by b
) data_total
join
(
	select g, n, data.b, c1, count(distinct a)
	from 
	(
		select a, trim(b) as b, c1, c2, c3, c4
		from data
		where length(c1) > 1
	) data
	full outer join bokovik on data.b = bokovik.b
	group by g, n, data.b, c1
) data_count on data_total.b = data_count.b
union all
(
	select n, g, coalesce(data_total.b, bokovik.b), 'Я Всего', coalesce(count, 0), case when count is NULL then '0.00'::numeric else round(100, 2)::numeric end
	from
	(
		select b, count(distinct a)
		from 
		(
			select a, trim(b) as b, c1, c2, c3, c4
			from data
			where length(c1) > 1
		) data
		group by b
	) data_total
	right join bokovik on data_total.b = bokovik.b
)
order by n, c1
) x