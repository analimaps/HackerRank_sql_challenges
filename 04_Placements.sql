--Author: Ana Paula Soares Lima 
--LinkedIn: https://www.linkedin.com/in/anapaulasoareslima/

/*Gathering Requirements
    only one column result
    only name of those students whose best friends got offered a higher salary than them

order by: Names must be ordered by the salary amount offered to the best friends
Note: I do not need verify if there are two students with the same salary offer

Output fields: name_student, hacker_id, name, and the sums of total_submissions, total_accepted_submissions, total_views, and total_unique_views
*/

----------------
----------------

--Solution

-- The trick here was using the same table twice in the join clause
select 
    s.name      as name
/*    f.id        as student_id,
    f.friend_id as friend_id,
    p.salary    as student_salary,
    pa.salary   as friend_salary*/
from students as s
join friends  as f
    on s.id = f.id
join packages as p
    on f.id = p.id
join packages as pa
    on f.friend_id = pa.id
where pa.salary > p.salary 
order by pa.salary 
