const { Pool } = require('pg');

//Connect to the bootcampx database in teachers.js
const pool = new Pool({            
  user: 'vagrant',
  password: '123',
  host: 'localhost',
  database: 'bootcampx'
});

//Use parameterized queries, protect from SQL injection:
const queryString = `
SELECT DISTINCT teachers.name as teacher, cohorts.name as cohort
FROM teachers
JOIN assistance_requests ON teachers.id = teacher_id
JOIN students ON student_id = students.id
JOIN cohorts ON cohort_id = cohorts.id
WHERE cohorts.name = $1
ORDER BY teacher;
`;

const cohortName = process.argv[2];
const values = [`${cohortName || 'JUL02'}`]

pool
  .query(queryString, values)
  .then(res => {
    res.rows.forEach(row => {
      console.log(`${row.cohort}: ${row.teacher}`);
    })
  })
  .catch(err => console.error('query error', err.stack));