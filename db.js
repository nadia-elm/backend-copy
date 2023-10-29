'use strict';
/** Database setup for store. */
const { Client } = require('pg');
const DB_URI = process.env.DATABASE_URL || 'postgresql:///storedb';

let db = new Client({
  connectionString: DB_URI,
});

// let DB_URI = process.env.DATABASE_URL;

// const client = new Client({
//   connectionString: connectionString,
//   ssl: {
//     rejectUnauthorized: false,
//   },
// });

db.connect();

module.exports = db;
