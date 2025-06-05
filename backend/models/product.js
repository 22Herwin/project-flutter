const mongoose = require('mongoose');
const AutoIncrement = require('mongoose-sequence')(mongoose);

// Define clothes tops schema
const productSchema = new mongoose.Schema({
  id: { type: Number, unique: true }, // Custom ID
  name: { type: String, required: true },
  price: { type: Number, required: true },
  size: { type: String, required: true },
  color: { type: String, required: true },
  inStock: { type: Boolean, default: true },
});

productSchema.plugin(AutoIncrement, {
  inc_field: 'id',
  id: 'product_id_counter',
});

module.exports = mongoose.model('product', productSchema);
