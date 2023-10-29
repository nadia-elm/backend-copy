const express = require('express');
const db = require('../db');

const router = new express.Router();

router.get('/', async (req, res, next) => {
  try {
    const response = await db.query(`SELECT * FROM products`);
    return res.json(response.rows);
  } catch (error) {
    return next(error);
  }
});
router.get('/:id', async (req, res, next) => {
  try {
    const { id } = req.params;
    const response = await db.query(`SELECT * FROM products WHERE id = $1`, [
      id,
    ]);
    return res.json(response.rows[0]);
  } catch (error) {
    return next(error);
  }
});

module.exports = router;
