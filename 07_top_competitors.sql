--Author: Ana Paula Soares Lima 
--LinkedIn: https://www.linkedin.com/in/anapaulasoareslima/

/*
Gathering requirements:
show only  hackers who achieved full scores for more than one challenge

Output fields: hacker_id, name
Sort by total number of challenges with full score DESC, hacker_id ASC
*/

----------------
----------------

--Solution
SELECT 
    h.hacker_id,
    h.name
FROM submissions        as s
INNER JOIN challenges   as c
    ON s.challenge_id = c.challenge_id
INNER JOIN difficulty   as d
    ON c.difficulty_level = d.difficulty_level
INNER JOIN hackers      as h
    ON s.hacker_id = h.hacker_id
WHERE s.score =d.score --bringing only where the score earned is equal the max score possible
GROUP BY h.hacker_id, h.name
HAVING count(*) > 1
ORDER BY count(*) DESC, h.hacker_id ASC
