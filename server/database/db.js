const pgp = require('pg-promise')();

const db = pgp({
  connectionString: 'postgres://THARINDU:123@localhost:5432/todoapp',
});

module.exports = db;
