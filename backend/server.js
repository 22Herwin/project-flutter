const express = require('express');
const cors = require('cors');
const { connectDB } = require('./config/database');
const app = express();
const port = 3000;

app.use(express.json());
app.use(cors());

// Route imports
const userRoutes = require('./routes/usersRoutes');
const productRoutes = require('./routes/productsRoutes');
const cartRoutes = require('./routes/cartRoutes');

// Route usage
app.use('/users', userRoutes);
app.use('/product', productRoutes);
app.use('cart', cartRoutes);

connectDB().then(() => {
  app.listen(port, '0.0.0.0', () =>
    console.log(`Server running on port ${port}...`)
  );
});
