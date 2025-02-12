/*
Ques: What are the most optimal skills to learn(aka it's in high demand and a high-paying skills)?
- Identify skill in high demand and associated with high average salaries for Data analyst roles
- Concentrate on remote positions with specified salaries
- Why? Targets skills that offer job security(High demand) and financial benefits(high salaries),
    offering strategic insights for career development in data analysis
    
*/

WITH skills_demand AS(
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills, 
        count(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = TRUE
    group by
        skills_dim.skill_id
), average_salary AS(
    select 
        skills_job_dim.skill_id, 
        ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_salary
    from job_postings_fact
    join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
    join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = TRUE
    group BY
        skills_job_dim.skill_id
)
SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
JOIN 
    average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count >10
order BY
    avg_salary DESC,
    demand_count desc
LIMIT 25
;

--rewriting this same query more concisely

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    count(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_salary
FROM
    job_postings_fact
JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25
;
