--Author: Ana Paula Soares Lima 
--LinkedIn: https://www.linkedin.com/in/anapaulasoareslima/

/*
Gathering Requirements:
    The result will be two different query with one column only;
        First Query : alphabetically ordered list of all names in OCCUPATIONS + first letter of each profession as a parenthetical. i.e: Ashely(P)
        Second Query: a text like: There are a total of [occupation_count] [occupation]s.     
*/

----------------
----------------

--Solution

--First Query
select distinct 
            concat (name, '(' ,left(occupation,1) , ')') as result
from occupations
order by result;

--Second Query
select distinct 
            concat('There are a total of ',number_of_professionals, ' ', occupation, 's.') as result
from (
      select lower(occupation) as occupation,
             count(*) as number_of_professionals
      from occupations
      group by occupation
      ) as count_professionals                  
order by result;    
