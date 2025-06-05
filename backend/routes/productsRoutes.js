const express = require('express');
const router = express.Router();
const { Product } = require('../config/database');

// Add product
router.post('/', async (req, res) => {
  try {
    const { name, price, size, color, inStock } = req.body;

    const newProduct = new Product({
      name,
      price,
      size,
      color,
      inStock,
    });

    await newProduct.save();
    res.status(201).json(newProduct);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// GET all product
router.get('/', async (req, res) => {
  try {
    const products = await Product.find();
    res.json(products);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// GET product by id
router.get('/:id', async (req, res) => {
  try {
    const product = await Product.findOne({ id: parseInt(req.params.id) });
    if (!product) return res.status(404).json({ message: 'Product not found' });

    res.json(product);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// PUT for update product by id
router.put('/:id', async (req, res) => {
  try {
    const updateProduct = await Product.findByIdAndUpdate(
      { id: parseInt(req.params.id) },
      req.body,
      { new: true }
    );

    if (!updateProduct)
      return res.status(404).json({ message: 'User not found' });

    res.json(updateProduct);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// DELETE product by id
router.delete('/:id', async (req, res) => {
  try {
    const deleteProduct = await Product.findOneAndDelete({
      id: parseInt(req.params.id),
    });

    if (!deleteProduct)
      return res.status(404).json({ message: 'User not found' });

    res
      .status(200)
      .json({ message: 'User deleted successfully', user: deleteProduct });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

module.exports = router;
