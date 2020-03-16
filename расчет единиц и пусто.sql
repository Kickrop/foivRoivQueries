with data as 
(
select *
from
get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vSwFNscG7aG9bcVBe3H4JWVqj8Izu1SZ_swWVeG79BKxv7YbNGyL8_8L12pS5K-cShgUQhhOJJIxn5Y/pub?gid=546210293&single=true&output=csv'::text) a(file_name text, foiv text, str_number integer, x1 text, x2 text, x3 text, x4 text, x5 text, x6 text, x7 text, x8 text, x9 text, x10 text)
)
-- select foiv, count(case when x1::int = '1' then x1::int end) x1_yes, --count(foiv) x1_zero, 
-- count(case when coalesce(x1::int, 0) = 0 then foiv end) x1_zero--count(coalesce(x1::int, 0) = 0)--, count(case when x1::int = '1' then x1::int end) x1_yes-- count(coalesce(x1::int, 0)) zero--, --count(x1)
-- from data
-- --group by foiv
-- --where coalesce(x1::int, 0) = 0
-- group by foiv
-- ; 

  select foiv, str_number, x1_yes, x1_zero, x1_all,
                       case when x1_all > 0 then round((x1_yes::float / x1_all::float * 100)::numeric, 2) end x1_yes_percent,
                       case when x1_all > 0 then round((x1_zero::float / x1_all::float * 100)::numeric, 2) end x1_zero_percent
                from
                               (
                               select foiv, str_number,
                               count(case when x1 = '1' then x1 end) x1_yes,
                               count(case when coalesce(x1::int, 0) = 0 then str_number end) x1_zero,                          
                               count(str_number) x1_all
                               from data
                               group by foiv, str_number
                               ) count_data
                order by foiv

