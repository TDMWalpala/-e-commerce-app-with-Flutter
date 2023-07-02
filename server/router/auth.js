const express = require('express');
const authRouter = express.Router();
const User = require('../models/user');
const bcrypt = require('bcryptjs');
const validation = require('../validation/validation');

authRouter.post('/api/signup',validation.validateInput, validation.validate, async (req, res) => {
  try {
    const { name, email, password } = req.body;
    const existingUser = await User.findOneByEmail(email);
    if (existingUser) {
      return res.status(400).json({ msg: 'User already exists!' });
    }
    const hashPassword =  await bcrypt.hash(password,8);
    await User.createUser(name, email, hashPassword);
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

authRouter.post('/api/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOneByEmail(email);
    if (!user) {
      return res.status(400).json({ msg: 'User not found!' });
    }
    if (user.password !== password) {
      return res.status(400).json({ msg: 'Invalid password!' });
    }
    res.json({ success: true, user });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = authRouter;
