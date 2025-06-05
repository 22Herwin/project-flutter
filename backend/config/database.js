const mongoose = require('mongoose');
const User = require('../models/users'); // schema for users
const Product = require('../models/product'); // schema for tops
const Cart = require('../models/cart');
require('dotenv').config();

// Connect to MongoDB
const connectDB = async () => {
  try {
    await mongoose.connect(process.env.MONGO_URI);
    console.log('Connected with MongoDB...');
  } catch (err) {
    console.log(`MongoDB connection error ${err}...`);
    process.exit(1);
  }
};

module.exports = { connectDB, User, Product, Cart };
