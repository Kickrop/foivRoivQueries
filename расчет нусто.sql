with data as 
(
select *
from
get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vSwFNscG7aG9bcVBe3H4JWVqj8Izu1SZ_swWVeG79BKxv7YbNGyL8_8L12pS5K-cShgUQhhOJJIxn5Y/pub?gid=425490771&single=true&output=csv'::text) a(file_name text, foiv text, str_number integer, x1 text, x2 text)
)
select foiv, str_number, x1_yes, x1_no, x1_all,
                       case when x1_all > 0 then round((x1_yes::float / x1_all::float * 100)::numeric, 2) end x1_yes_percent,
                       case when x1_all > 0 then round((x1_no::float / x1_all::float * 100)::numeric, 2) end x1_no_percent
                from
                               (
                               select foiv, str_number,
                               count(case when x1 = '1' then x1 end) x1_yes,
                               count(case when coalesce(x1::int, 2) = 2 then str_number end) x1_no,
                               --count(case when x1 = '2' then x1 end) x1_no,                        
                               count(str_number) x1_all
                               from data
                               group by foiv, str_number
                               ) count_data
                order by foiv 
