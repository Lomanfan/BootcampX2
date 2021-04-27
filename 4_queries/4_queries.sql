--Get the total number of assistance_requests for a teacher.
SELECT count(assistance_requests.*) as total_assistances, teachers.name
FROM assistance_requests
JOIN teachers ON teachers.id = teacher_id
WHERE name = 'Waylon Boehm'
GROUP BY teachers.name;


--Get the total number of assistance_requests for a student.
SELECT count(assistance_requests.*) as total_assistances, students.name
FROM assistance_requests
JOIN students ON students.id = student_id
WHERE name = 'Elliot Dickinson'
GROUP BY students.name;


--Get important data about each assistance request.
SELECT teachers.name as teacher, students.name as student, assignments.name as assignment, (completed_at-started_at) as duration
FROM assistance_requests
JOIN teachers ON teachers.id = teacher_id
JOIN students ON students.id = student_id
JOIN assignments ON assignments.id = assignment_id
ORDER BY duration;


--Get the average time of an assistance request.
SELECT AVG(completed_at - started_at) as average_assistance_request_duration
FROM assistance_requests;


--Get the average duration of assistance requests for each cohort.
SELECT cohorts.name as name, AVG(completed_at - started_at) as average_assistance_time
FROM assistance_requests
JOIN students ON students.id = student_id   -- assistance_requests.student_id --
JOIN cohorts ON cohorts.id = cohort_id
GROUP BY cohorts.name
ORDER BY average_assistance_time;


--Get the cohort with the longest average duration of assistance requests.
SELECT cohorts.name as name, AVG(completed_at - started_at) as average_assistance_time
FROM assistance_requests
JOIN students ON students.id = student_id   -- assistance_requests.student_id --
JOIN cohorts ON cohorts.id = cohort_id
GROUP BY cohorts.name
ORDER BY average_assistance_time DESC
LIMIT 1;


--Calculate the average time it takes to start an assistance request.
SELECT AVG(started_at-created_at) as average_wait_time
FROM assistance_requests;


--Get the total duration of all assistance requests for each cohort.
SELECT cohorts.name as cohort, SUM(completed_at - started_at) as total_duration
FROM assistance_requests
JOIN students ON students.id = student_id   -- assistance_requests.student_id --
JOIN cohorts ON cohorts.id = cohort_id
GROUP BY cohorts.name
ORDER BY total_duration;


--Calculate the average total duration of assistance requests <for each cohort>.
SELECT AVG(total_duration) as average_total_duration
FROM (
  SELECT SUM(completed_at - started_at) as total_duration
  FROM assistance_requests
  JOIN students ON students.id = student_id
  JOIN cohorts ON cohorts.id = cohort_id
  GROUP BY cohorts.name
) as total_duration;

-- per Compass:-------------------------------------------------------------------------------------------
SELECT avg (total_duration) as average_total_duration
FROM (
  SELECT cohorts.name as cohort, sum(completed_at-started_at) as total_duration
  FROM assistance_requests
  JOIN students ON students.id = student_id
  JOIN cohorts on cohorts.id = cohort_id
  GROUP BY cohorts.name
  ORDER BY total_duration
) as total_durations;
-----------------------------------------------------------------------------------------------------------


--List each assignment with the total number of assistance requests with it.
SELECT assignments.id, name, day, chapter, count(assistance_requests.*) as total_requests 
FROM assignments
JOIN assistance_requests ON assignments.id = assignment_id
GROUP BY assignments.id
ORDER BY total_requests DESC;


--Get each day with the total number of assignments and the total duration of the assignments.
SELECT day, count(*) as number_of_assignments, SUM(duration) as duration
FROM assignments
GROUP BY day
ORDER BY day ASC;


--Get the name of all teachers that performed an assistance request during a cohort.
SELECT DISTINCT teachers.name as teacher, cohorts.name as cohort
FROM teachers
JOIN assistance_requests ON teachers.id = teacher_id
JOIN students ON student_id = students.id
JOIN cohorts ON cohort_id = cohorts.id
WHERE cohorts.name = 'JUL02'
ORDER BY teacher;


--Perform the same query as before, but include the number of assistances as well.
SELECT teachers.name as teacher, cohorts.name as cohort, COUNT(assistance_requests.*) as total_assistances
FROM assistance_requests
JOIN teachers ON teacher_id = teachers.id
JOIN students ON student_id = students.id
JOIN cohorts ON cohort_id = cohorts.id
WHERE cohorts.name = 'JUL02'
GROUP BY teachers.name, cohorts.name
ORDER BY teacher;


--per Compass:---------------------------------------------------------------------------------------------------
SELECT DISTINCT teachers.name as teacher, cohorts.name as cohort, COUNT(assistance_requests) as total_assistances
FROM teachers
JOIN assistance_requests ON teachers.id = teacher_id
JOIN students ON student_id = students.id
JOIN cohorts ON cohort_id = cohorts.id
WHERE cohorts.name = 'JUL02'
GROUP BY teachers.name, cohorts.name
ORDER BY teacher;
-----------------------------------------------------------------------------------------------------------------
