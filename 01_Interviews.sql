--Author: Ana Paula Soares Lima 
--LinkedIn: https://www.linkedin.com/in/anapaulasoareslima/

/*Gathering Requirements
  for each contest --left join
  sorted by contest_id --order by asc
  excludes where all the sums = 0  --having clause
  Note for validation: A specific contest can be used to screen candidates at more than one college, but each college only holds 1 screening contest.

Output fields: contest_id, hacker_id, name, and the sums of total_submissions, total_accepted_submissions, total_views, and total_unique_views
*/

----------------
----------------

--Solution

with sum_Submission_Stats as (
        select 
            challenge_id,
            sum(total_submissions)          as total_submissions,
            sum(total_accepted_submissions) as total_accepted_submissions
        from submission_stats
        group by challenge_id
),
      sum_View_Stats as (
         select 
            challenge_id,
            sum(total_views)        as total_views,
            sum(total_unique_views) as total_unique_views
         from View_Stats
         group by challenge_id
),
      sum_colleges as (
         select
            college_id,
            sum(total_submissions)          as total_submissions,
            sum(total_accepted_submissions) as total_accepted_submissions,
            sum(total_views)                as total_views,
            sum(total_unique_views)         as total_unique_views
         from challenges                as ch
         left join sum_Submission_Stats as sss
            on ch.challenge_id = sss.challenge_id
         left join sum_View_Stats       as svs
            on ch.challenge_id = svs.challenge_id
         group by college_id
)
select 
    ctt.contest_id, 
    ctt.hacker_id, 
    ctt.name, 
    sum(scll.total_submissions)             as total_submissions,
    sum(scll.total_accepted_submissions)    as total_accepted_submissions,
    sum(scll.total_views)                   as total_views,
    sum(scll.total_unique_views)            as total_unique_views
from contests           as ctt
left join colleges      as cll
    on ctt.contest_id = cll.contest_id
left join sum_colleges  as scll
    on cll.college_id = scll.college_id
group by ctt.contest_id, ctt.hacker_id, ctt.name
having sum(scll.total_submissions) > 0 and 
       sum(scll.total_accepted_submissions) > 0 and
       sum(scll.total_views) > 0 and
       sum(scll.total_unique_views) > 0
order by ctt.contest_id
