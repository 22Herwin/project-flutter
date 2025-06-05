import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Tambahan untuk format Rupiah
import 'package:butik_krisna/models/cart_item.dart';

class CartPage extends StatefulWidget {
  final List<CartItem> cartItems;

  CartPage({required this.cartItems});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _removeItem(int index) {
    setState(() {
      widget.cartItems.removeAt(index);
    });
  }

  void _updateQuantity(int index, int delta) {
    setState(() {
      widget.cartItems[index].quantity += delta;
      if (widget.cartItems[index].quantity <= 0) {
        widget.cartItems.removeAt(index);
      }
    });
  }

  int get totalItems =>
      widget.cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      widget.cartItems.fold(0, (sum, item) => sum + item.product.price * item.quantity);

  String formatCurrency(double value) {
    return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0).format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Cart')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];
                return ListTile(
                  leading: Image.network(item.product.imageUrl, width: 50),
                  title: Text(item.product.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${formatCurrency(item.product.price)} x ${item.quantity}'),
                      Text('Subtotal: ${formatCurrency(item.product.price * item.quantity)}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () => _updateQuantity(index, -1),
                      ),
                      Text('${item.quantity}'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => _updateQuantity(index, 1),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _removeItem(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Total Items: $totalItems'),
                Text('Total Price: ${formatCurrency(totalPrice)}'),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (widget.cartItems.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Your cart is empty!')),
                      );
                    } else {
                      Navigator.pushNamed(context, '/payment');
                    }
                  },
                  child: Text('Proceed to Payment'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
