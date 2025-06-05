const express = require('express');
const router = express.Router();
const { Cart, Product } = require('../config/database');

// Get user's cart
router.get('/:userId', async (req, res) => {
  try {
    const cart = await Cart.findOne({ user: req.params.userId }).populate(
      'items.product'
    );

    if (!cart) {
      return res.status(200).json({ items: [] });
    }

    res.json(cart);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Add/update item in cart
router.post('/:userId', async (req, res) => {
  try {
    const { productId, quantity, selectedSize, selectedColor } = req.body;

    const product = await Product.findById(productId);
    if (!product) {
      return res.status(404).json({ message: 'Product not found' });
    }

    let cart = await Cart.findOne({ user: req.params.userId });

    if (!cart) {
      cart = new Cart({
        user: req.params.userId,
        items: [],
      });
    }

    const existingItemIndex = cart.items.findIndex(
      (item) => item.product.toString() === productId
    );

    if (existingItemIndex >= 0) {
      // Update existing item
      cart.items[existingItemIndex].quantity += quantity;
    } else {
      // Add new item
      cart.items.push({
        product: productId,
        quantity,
        selectedSize,
        selectedColor,
      });
    }

    cart.updatedAt = new Date();
    await cart.save();

    res.status(200).json(await cart.populate('items.product'));
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Remove item from cart
router.delete('/:userId/:productId', async (req, res) => {
  try {
    const cart = await Cart.findOne({ user: req.params.userId });

    if (!cart) {
      return res.status(404).json({ message: 'Cart not found' });
    }

    cart.items = cart.items.filter(
      (item) => item.product.toString() !== req.params.productId
    );

    cart.updatedAt = new Date();
    await cart.save();

    res.status(200).json(await cart.populate('items.product'));
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Update item quantity
router.put('/:userId/:productId', async (req, res) => {
  try {
    const { quantity } = req.body;
    const cart = await Cart.findOne({ user: req.params.userId });

    if (!cart) {
      return res.status(404).json({ message: 'Cart not found' });
    }

    const itemIndex = cart.items.findIndex(
      (item) => item.product.toString() === req.params.productId
    );

    if (itemIndex < 0) {
      return res.status(404).json({ message: 'Item not found in cart' });
    }

    if (quantity <= 0) {
      cart.items.splice(itemIndex, 1);
    } else {
      cart.items[itemIndex].quantity = quantity;
    }

    cart.updatedAt = new Date();
    await cart.save();

    res.status(200).json(await cart.populate('items.product'));
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

module.exports = router;
