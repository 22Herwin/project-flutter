import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:butik_krisna/models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  final void Function(Product)? onAddToCart;

  const ProductDetailPage({
    super.key,
    required this.product,
    this.onAddToCart,
  });
  String _formatCurrency(num value) {
    return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)
        .format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.imageUrl,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              product.title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              _formatCurrency(product.price),
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            SizedBox(height: 8),
            Text(
              product.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Warna: ${product.colors?.join(', ') ?? '-'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              product.size ?? '-',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Stock: ${product.stock?.join(', ') ?? '-'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  onAddToCart?.call(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Ditambahkan ke keranjang!'),
                        duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Text('Tambah ke Keranjang'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
