'use strict';
/** Database setup for store. */
const { Client } = require('pg');
// const { getDatabaseUri } = require('./config');

let DB_URI = process.env.DATABASE_URL;

// if (process.env.NODE_ENV === 'test') {
//   DB_URI = 'postgresql:///storedb_test';
// } else {
//   DB_URI = 'postgresql:///storedb';
// }

// let db = new Client({
//   connectionString: DB_URI,
// });

const client = new Client({
  connectionString: connectionString,
  ssl: {
    rejectUnauthorized: false,
  },
});

db.connect();

module.exports = db;
