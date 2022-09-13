--Author: Ana Paula Soares Lima 
--LinkedIn: https://www.linkedin.com/in/anapaulasoareslima/

/*
Gathering requirements:
total number of unique hackers who made at least 1 submission each day
hacker_id and name of the hacker who made maximum number of submissions each day
If more than one such hacker has a maximum number of submissions, print the lowest hacker_id
Sort by date

Output fields: submission_date, number of unique hackers, hacker_id, hacker_name
*/

----------------
----------------

--Solution

--date_table: giving a number for each day by ascending order
with date_table as ( 
        select submission_date,
               rank() over (order by submission_date) as rank_date
        from (
              select distinct submission_date
              from submissions
              where submission_date >= '2016-03-01'
              ) as dist_date
),
--sub_rank: each day of a hacker_id get a number in ascending order
 sub_rank as (
        select submission_date,
               hacker_id,
               rank() over (partition by hacker_id order by submission_date) as rank_date_hacker
        from (
              select distinct submission_date, 
                              hacker_id 
              from submissions
              where submission_date >= '2016-03-01'
              ) as dist_hacker_date 
),
--unique_hackers: case the number of the day between the two table isn't the same, it means that the hacker_id miss at least one day in the competition, and the difference will only appear after the first missed day.
unique_hackers as (
select d.submission_date,
       count(case when d.rank_date = s.rank_date_hacker then 1 end) as unique_hackers
from date_table      as d
left join sub_rank   as s
    on d.submission_date = s.submission_date
group by d.submission_date
),
--max_sub_hacker: verifying which hacker submitted more in each day, ordering by hacker_id asc
max_sub_hacker as (
    select  submission_date, 
            hacker_id, 
            count(submission_id) as qtt_submission,
            row_number() over (partition by submission_date order by count(submission_id) desc, hacker_id asc) as rownumber
    from submissions
    group by submission_date, hacker_id
)
--final result
select m.submission_date,
       u.unique_hackers,
       h.hacker_id,
       h.name
from hackers            as h
join max_sub_hacker     as m
    on h.hacker_id = m.hacker_id
join unique_hackers     as u
    on m.submission_date = u.submission_date
where m.submission_date >= '2016-03-01' and rownumber = 1
