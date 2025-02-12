/*
Ques: What are the most in-demand skills for data analysis ?
- Join job posting to inner join table similar to query 2
- Identify the top-5 In-demand skills for a data analyst
- Focus on all job postings
- Why? Retrieves the top 5 skills with the highest demand in the job market
    providing insights into most valuable skills for job seekers
*/


SELECT 
    skills, count(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE
group by
    skills
order BY
    demand_count DESC
limit 5
;

select * from job_postings_fact limit 5;