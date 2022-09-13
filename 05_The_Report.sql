--Author: Ana Paula Soares Lima 
--LinkedIn: https://www.linkedin.com/in/anapaulasoareslima/

/*Gathering Requirements
    if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order
    If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically
    If there is more than one student with the same grade (1- 7) assigned to them,  order those particular students by their marks in ascending order
    
Output fields: Name, Grade, Mark
*/

----------------
----------------

--Solution
with info as (
    select 
        name,
        grade,
        marks as mark
    from students as s
    join grades   as g
        on s.marks >= g.min_mark and s.marks <= max_mark
),
grades_8_10 as (
    select *
    from info
    where grade >= 8
    order by grade desc, name asc offset 0 rows
),
grades_1_7 as (
    select 
        NULL as name,
        grade,
        mark
    from info
    where grade < 8
    order by grade desc, name asc, mark asc offset 0 rows
)
select * 
from grades_8_10
    union all
select * 
from grades_1_7
