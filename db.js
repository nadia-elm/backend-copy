'use strict';

/** Database setup for store. */
const { Client } = require('pg');

const DB_URI = process.env.DATABASE_URL || 'postgresql:///storedb';

let db = new Client({
  connectionString: DB_URI,
  ssl:
    process.env.NODE_ENV === 'production'
      ? { rejectUnauthorized: false }
      : false,
});

db.connect();

module.exports = db;
