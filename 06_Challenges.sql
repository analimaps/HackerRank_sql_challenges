--Author: Ana Paula Soares Lima 
--LinkedIn: https://www.linkedin.com/in/anapaulasoareslima/

/*Gathering Requirements
Output fields: hacker_id, name, # challenges created by each student
order by # challenges created by each student DESC

If more than one student created the same # of challenges, then order by hacker_id
If more than one student created the same # of challenges and the count is < max(# of challenges), then exclude those students from the result.


                              
*/

----------------
----------------

--Solution
declare @max as int
SET @max = (
              select top 1 
                         count(*) as max_challenge
              from challenges
              group by hacker_id
              order by count(*) DESC
             );
             
with join_table as (
        select 
            h.hacker_id,
            h.name,
            count(c.challenge_id) as total_challenges_created,
            row_number() over (order by count(c.challenge_id) DESC, h.hacker_id ASC) as row_num,
            count(*) over (partition by count(c.challenge_id)) as count_num
        from hackers             as h
        inner join challenges   as c
            on h.hacker_id = c.hacker_id
        group by h.name, h.hacker_id
        order by total_challenges_created DESC, h.hacker_id ASC offset 0 rows
)             
select         
    hacker_id,
    name,
    total_challenges_created   
from  join_table
where count_num = 1 or total_challenges_created = @max
--mantaining everyone who doesn't have anybody with the same number of challenges and mantaining everyone with the max number of challanges
