/*
Ques: What are the top skills based on salary ?
- Look at the avg salary associated with each skill for Data analyst positions
- Focuses on role with specified salaries, regardless of location
- Why ? It reveals how different skills impact salary levels for Data Analysts and
    helps identify the most financially rewarding skills to acquire or imrpove
*/

select * from job_postings_fact limit 5;
select * from skills_dim limit 5;
select * from skills_job_dim limit 5;

select 
    skills, 
    ROUND(AVG(salary_year_avg),0) AS avg_salary
from job_postings_fact
join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
group BY
    skills
order BY
    avg_salary DESC
limit 25;
