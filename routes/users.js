const express = require('express');
const bcrypt = require('bcrypt');
const db = require('../db');
const jwt = require('jsonwebtoken');
const authenticateJWT = require('../middleware.js/auth');

const router = express.Router();

// User registration
router.post('/register', async (req, res, next) => {
  try {
    // return res.send('register route');
    const { username, password, email } = req.body;
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    const response = await db.query(
      'INSERT INTO users(username, password, email) VALUES($1, $2, $3) RETURNING *',
      [username, hashedPassword, email]
    );
    const newUser = response.rows[0];
    const token = jwt.sign({ userId: newUser.id }, 'secretkey');
    res.json({ token, user: newUser });
  } catch (error) {
    next(error);
  }
});

// User login
router.post('/login', async (req, res, next) => {
  try {
    const { username, password } = req.body;
    console.log(username, password);

    const response = await db.query('SELECT * FROM users WHERE username = $1', [
      username,
    ]);

    if (response.rows.length === 0) {
      console.log('User not found');
    } else {
      console.log('User found');
    }

    const user = response.rows[0];

    if (user && (await bcrypt.compare(password, user.password))) {
      const token = jwt.sign({ userId: user.id }, 'secretkey');
      console.log(process.env.SECRET_KEY);
      res.json({ token, user });
      console.log(token);
    } else {
      res.status(401).json({ message: 'Invalid username or password' });
    }
  } catch (error) {
    next(error);
  }
});

router.post('/favorites', authenticateJWT, async (req, res, next) => {
  try {
    const { productId } = req.body;
    const userId = req.user.userId; // Get userId from the token

    await db.query(
      'INSERT INTO favorites(user_id, product_id) VALUES($1, $2) RETURNING *',
      [userId, productId]
    );
    res.status(200).json({ message: 'Product added to favorites' });
  } catch (error) {
    next(error);
  }
});

router.get('/favorites', authenticateJWT, async (req, res, next) => {
  try {
    const userId = req.user.userId; // Get userId from the token

    const response = await db.query(
      'SELECT p.* FROM favorites f JOIN products p ON f.product_id = p.id WHERE f.user_id = $1',
      [userId]
    );
    res.status(200).json(response.rows);
  } catch (error) {
    next(error);
  }
});

// Check if a product is in favorites
router.get(
  '/favorites/check/:productId',
  authenticateJWT,
  async (req, res, next) => {
    try {
      const userId = req.user.userId; // Get userId from the token
      const { productId } = req.params; // Get productId from the URL parameter

      const response = await db.query(
        'SELECT * FROM favorites WHERE user_id = $1 AND product_id = $2',
        [userId, productId]
      );

      if (response.rows.length > 0) {
        return res.json({ isFavorite: true });
      } else {
        return res.json({ isFavorite: false });
      }
    } catch (error) {
      next(error);
    }
  }
);

//
router.delete('/favorites', authenticateJWT, async (req, res, next) => {
  try {
    const { productId } = req.body;
    const userId = req.user.userId; // Get userId from the token

    await db.query(
      'DELETE FROM favorites WHERE user_id = $1 AND product_id = $2',
      [userId, productId]
    );
    res.status(200).json({ message: 'Removed from favorites' });
  } catch (error) {
    next(error);
  }
});

module.exports = router;
