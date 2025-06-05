const fs = require('fs');
const express = require('express');
const multer = require('multer');
const argon2 = require('argon2');
const { User } = require('../config/database');
const router = express.Router();

const upload = multer({ dest: 'uploads/' });

// Upload profile image and attach to user
router.post('/upload/:id', upload.single('image'), async (req, res) => {
  try {
    const userId = req.params.id;
    const imageData = fs.readFileSync(req.file.path);
    const encodedImage = imageData.toString('base64');

    const updatedUser = await User.findOneAndUpdate(
      { id: userId },
      { image: encodedImage },
      { new: true }
    );

    fs.unlinkSync(req.file.path); // Remove temp file
    res.status(200).json(updatedUser.toJSON());
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Login route
router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;

    // Find user by email
    const user = await User.findOne({ email });
    if (!user) return res.status(404).json({ message: 'User not found' });

    // Compare password using argon2
    const isMatch = await argon2.verify(user.password, password);
    if (!isMatch) return res.status(401).json({ message: 'Invalid password' });

    // Login success
    res.status(200).json({ message: 'Login successful', user });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Create user
router.post('/', async (req, res) => {
  try {
    const { name, email, password } = req.body;

    // Check if user with the same email already exists
    const existingEmail = await User.findOne({ email });
    if (existingEmail) {
      return res.status(400).json({ message: 'Email already in use' });
    }

    // Check if user with the same name already exists
    const existingName = await User.findOne({ name: req.body.name });
    if (existingName) {
      return res.status(400).json({ message: 'Username already taken' });
    }

    // If checks pass, hash password and create user
    const hashedPassword = await argon2.hash(password);
    const newUser = new User({ name, email, password: hashedPassword });
    await newUser.save();

    res.status(201).json(newUser.toJSON());
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
});

// Get all users
router.get('/', async (req, res) => {
  try {
    const users = await User.find();
    res.json(users);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Get user by id
router.get('/:id', async (req, res) => {
  try {
    const user = await User.findOne({ id: parseInt(req.params.id) });
    if (!user) return res.status(404).json({ message: 'User not found' });

    res.json(user);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Update user by id
router.put('/:id', async (req, res) => {
  try {
    const { name, email, password } = req.body;
    const userId = parseInt(req.params.id);

    const user = await User.findOne({ id: userId });
    if (!user) return res.status(404).json({ message: 'User not found' });

    // Check name/email uniqueness (excluding current user)
    const nameExists = await User.findOne({ name: req.body.name });
    if (nameExists && nameExists.id !== userId) {
      return res.status(400).json({ message: 'Username already taken' });
    }

    const emailExists = await User.findOne({ email });
    if (emailExists && emailExists.id !== userId) {
      return res.status(400).json({ message: 'Email already in use' });
    }

    // Update fields
    user.name = name;
    user.email = email;
    if (password) {
      user.password = await argon2.hash(password);
    }

    await user.save();
    res.json(user.toJSON());
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Delete user by id
router.delete('/:id', async (req, res) => {
  try {
    const deleteUser = await User.findOneAndDelete({
      id: parseInt(req.params.id),
    });
    if (!deleteUser) return res.status(404).json({ message: 'User not found' });
    res
      .status(200)
      .json({ message: 'User deleted successfully', user: deleteUser });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

module.exports = router;
