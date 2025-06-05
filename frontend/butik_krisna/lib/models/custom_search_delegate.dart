import 'package:flutter/material.dart';
import 'package:butik_krisna/models/product.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<Product> products;

  CustomSearchDelegate({required this.products});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredProducts = products
        .where((product) =>
        product.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Container(
      color: Colors.white, // White background for results
      child: ListView.builder(
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(filteredProducts[index].imageUrl, width: 50),
            title: Text(filteredProducts[index].title),
            subtitle: Text(filteredProducts[index].description),
            trailing: Text('\$${filteredProducts[index].price}'),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/productDetail',
                arguments: filteredProducts[index],
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = products
        .where((product) =>
        product.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Container(
      color: Colors.white, // White background for suggestions
      child: ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(suggestions[index].imageUrl, width: 50),
            title: Text(suggestions[index].title),
            subtitle: Text(suggestions[index].description),
            onTap: () {
              query = suggestions[index].title;
              showResults(context);
            },
          );
        },
      ),
    );
  }
}
