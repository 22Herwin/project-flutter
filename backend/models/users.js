const mongoose = require('mongoose');
const AutoIncrement = require('mongoose-sequence')(mongoose);

// Define Users schema
const userSchema = new mongoose.Schema({
  id: { type: Number, unique: true }, // Custom id
  name: { type: String, required: true },
  email: { type: String, required: true },
  password: { type: String, required: true },
  image: { type: String },
});

userSchema.plugin(AutoIncrement, {
  inc_field: 'id',
  id: 'user_id_counter',
});

module.exports = mongoose.model('User', userSchema);
