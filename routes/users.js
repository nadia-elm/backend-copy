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

// add to favorites

router.post('/favorites', authenticateJWT, async (req, res, next) => {
  console.log(req.user);
  try {
    const { userId, productId } = req.body;
    console.log(req.body);
    if (req.user.userId !== userId) {
      console.log(req.user.userId, userId);
      res.status(401).json({ message: 'Unauthorized' });
    }
    await db.query(
      'INSERT INTO favorites(user_id, product_id) VALUES($1, $2) RETURNING *',
      [userId, productId]
    );
  } catch (error) {
    next(error);
  }
});

// get favorites
router.get('/favorites', authenticateJWT, async (req, res, next) => {
  try {
    const { userId, productId } = req.query;
    console.log('User ID from Token:', req.user.userId, typeof req.user.userId);
    console.log('User ID from Request Body:', userId, typeof userId);

    if (Number(req.user.userId) !== Number(userId)) {
      // Ensure both are numbers before comparison
      console.log('Unauthorized: User ID mismatch');
      return res.status(401).json({ message: 'Unauthorized' }); // Added return to prevent further execution
    }
    // if (req.user.userId !== userId) {
    //   res.status(401).json({ message: 'Unauthorized' });
    // }
    const response = await db.query(
      'SELECT * FROM favorites WHERE user_id = $1 AND product_id = $2',
      [userId, productId]
    );
    if (response.rows.length > 0) {
      return res.json({ isFavorite: true });
    } else {
      return res.json({ isFavorite: false });
    }
    res.json(response.rows);
  } catch (error) {
    next(error);
  }
});

router.delete('/favorites', authenticateJWT, async (req, res, next) => {
  try {
    const { userId, productId } = req.body;
    if (req.user.userId !== userId) {
      res.status(401).json({ message: 'Unauthorized' });
    }
    await db.query(
      'DELETE FROM favorites WHERE user_id = $1 AND product_id = $2',
      [userId, productId]
    );
    res.json({ message: 'Removed from favorites' });
  } catch (error) {
    return next(error);
  }
});
module.exports = router;
