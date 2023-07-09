const express = require('express');
const authRouter = express.Router();
const User = require('../models/user');
const bcrypt = require('bcryptjs');
const validation = require('../validation/validation');
const jwt = require('jsonwebtoken');
const auth = require('../middleware/auth');


authRouter.post('/api/signup', validation.validateInput, validation.validate, async (req, res) => {
  try {
    const { name, email, password } = JSON.parse(req.body);

    const existingUser = await User.findOneByEmail(email);
    if (existingUser) {
      return res.status(400).json({ msg: 'User already exists!' });
    }
    const hashPassword = await bcrypt.hash(password, 8);
    await User.createUser(name, email, hashPassword);
    res.json({ success: req.body });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

authRouter.post('/api/signin', async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOneByEmail(email);
    if (!user) {
      return res.status(400).json({ msg: 'User not found!' });
    }
    const isMatch = await bcrypt.compare(password,user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: 'Invalid password!' });
    }

    const token =  jwt.sign({id:user.id}, "passwordKey");
    res.json({ success: true,token, ...user});
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

authRouter.post('/tokenIsValid', async (req, res) => {
  try {

    const token = req.header('x-auth-token');
    if(!token) return res.json(false);

    const verified =  jwt.verify(token, "passwordKey");
    if(!verified) return res.json(false);

    const user = await User.findOneById(verified.id);
    if(!user) return res.json(false);

    res.json(true);

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

authRouter.get('/', auth, async(req,res)=>{
  const user = await User.findOneById(req.user);
  res.json({...user, token: req.token})
})

module.exports = authRouter;
