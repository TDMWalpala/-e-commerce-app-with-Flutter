const express = require('express');
const app = express();
const db = require('./database/db');

const authRouter = require('./router/auth');

app.use(express.json({ limit: '10mb', extended: true, strict: false }));
app.use(authRouter);

const PORT = 4000; // Change the port number to an available port

// Check if the database is connected
db.connect()
  .then(() => {
    console.log('Database connected');
    // Start the server after the database connection is established
    app.listen(PORT, () => {
      console.log(`Connected at port ${PORT}`);
    });
  })
  .catch((error) => {
    console.error('Error connecting to the database:', error);
  });
