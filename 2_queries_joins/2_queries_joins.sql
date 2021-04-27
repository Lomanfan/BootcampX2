--Get the total amount of time that a student has spent on all assignments.

SELECT sum(assignment_submissions.duration) as total_duration
FROM assignment_submissions
JOIN students ON students.id = student_id
WHERE students.name = 'Ibrahim Schimmel';

 total_duration 
----------------
           6888
(1 row)



--Get the total amount of time that all students from a specific cohort have spent on all assignment

SELECT sum(assignment_submissions.duration) as total_duration
FROM assignment_submissions
JOIN students ON students.id = student_id
JOIN cohorts ON cohorts.id = cohort_id
WHERE cohorts.name = 'FEB12';

 total_duration 
----------------
         373501
(1 row)