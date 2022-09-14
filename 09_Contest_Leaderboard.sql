--Author: Ana Paula Soares Lima 
--LinkedIn: https://www.linkedin.com/in/anapaulasoareslima/

/*Gathering Requirements
Total score of a hacker: SUM of their maximum scores for all of the challenges

Output fields: hacker_id, name, total score
Order by total score DESC, hacker_id ASC
filters: score > 0
*/

----------------
----------------

--Solution
--table max_score_per_challenge: goal is to obtain the max score per challenge
with max_score_per_challenge as (
    SELECT
        h.hacker_id,
        h.name,
        s.challenge_id,
        max(s.score) as max_score_per_challenge
    FROM hackers            as h
    INNER JOIN submissions  as s
        ON h.hacker_id = s.hacker_id  
    GROUP BY h.hacker_id, h.name, s.challenge_id
)
--obtaining the score per hacker
SELECT 
    hacker_id,
    name,
    sum(max_score_per_challenge) as total_score
FROM max_score_per_challenge
GROUP BY hacker_id, name
HAVING sum(max_score_per_challenge) > 0
ORDER BY total_score DESC, hacker_id ASC
