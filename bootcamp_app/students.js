const { Pool } = require('pg');

const pool = new Pool({            //Connect to the bootcampx database in students.js
  user: 'vagrant',
  password: '123',
  host: 'localhost',
  database: 'bootcampx'
});


// pool
// .query(`SELECT id, name, cohort_id 
//         FROM students 
//         LIMIT 5;`)
// .then(res => {
//   // console.log(res);
//   console.log(res.rows);
// })
// .catch(err => console.error('query error', err.stack));
// //pool.query is a function that accepts an SQL query as a JavaScript string. 
// //Using the ` (backtick) write a multi line string like this to make our SQL look nicer
// //The function then returns a promise that contains our result when the query is successful.


// pool.query(`
// SELECT id, name, cohort_id
// FROM students
// LIMIT 5;
// `)
// .then(res => {
//   res.rows.forEach(user => {
//     console.log(`${user.name} has an id of ${user.id} and was in the ${user.cohort_id} cohort`);
//   })
// });


// pool.query(`
//   SELECT students.id as student_id, students.name as name, cohorts.name as cohort
//   FROM students
//   JOIN cohorts ON cohorts.id = cohort_id
//   LIMIT 5;
// `)
// .then(res => {
//   res.rows.forEach(user => {
//     console.log(`${user.name} has an id of ${user.student_id} and was in the ${user.cohort} cohort`);
//   })
// });


//node students.js FEB 2 (Command Line Argument: FEB is the cohort name and 2 is the maximum number of results)
//Expected Result:
// Armand Hilll has an id of 1 and was in the FEB12 cohort
// Stephanie Wolff has an id of 2 and was in the FEB12 cohort
pool.query(`
  SELECT students.id as student_id, students.name as name, cohorts.name as cohort
  FROM students
  JOIN cohorts ON cohorts.id = cohort_id
  WHERE cohorts.name LIKE '${process.argv[2]}%'
  LIMIT ${process.argv[3] || 5};
`)
.then(res => {
  res.rows.forEach(user => {
    console.log(`${user.name} has an id of ${user.student_id} and was in the ${user.cohort} cohort`);
  })
}).catch(err => console.error('query error', err.stack));


