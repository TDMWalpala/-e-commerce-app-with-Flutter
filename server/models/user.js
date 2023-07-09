const db = require('../database/db');

const User = {
  findOneByEmail: async (email) => {
    try {
      const query = 'SELECT * FROM users1 WHERE email = $1';
      const user = await db.oneOrNone(query, [email]);
      return user;
    } catch (error) {
      throw new Error('Error finding user:', error);
    }
  },
  findOneById: async (id) => {
    try {
      const query = 'SELECT * FROM users1 WHERE id = $1';
      const user = await db.oneOrNone(query, [id]);
      return user;
    } catch (error) {
      throw new Error('Error finding user:', error);
    }
  },
  createUser: async (name, email, password) => {
    try {
      const query = 'INSERT INTO users1(name, email, password) VALUES($1, $2, $3)';
      await db.none(query, [name, email, password]);
      console.log('User created successfully');
    } catch (error) {
      throw new Error('Error creating user:', error);
    }
  },
};

module.exports = User;
