import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:butik_krisna/models/product.dart';
import 'package:butik_krisna/models/cart_item.dart';
import 'package:butik_krisna/pages/content/product_detail_page.dart';
import 'package:butik_krisna/models/custom_search_delegate.dart';

class HomePage extends StatefulWidget {
  final Map<String, dynamic> user;
  const HomePage({super.key, required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Map<String, dynamic> user;

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  final List<Product> suggestedProducts = [
    Product(
      id: '1',
      title: 'Night Dress Party',
      imageUrl: 'https://www.cocaranti.com/wp-content/uploads/2022/04/Mads-Norgaard-1x1-Delkissa-Dress-BlackWhitecap-Grey-2.jpg',
      description: 'Dress For Party',
      colors: ['Red', 'Blue', 'Green'],
      price: 50000,
      size: 'Size: S, M, L',
      stock: ['38']
    ),
    Product(
      id: '2',
      title: 'Blue Jeans Dress',
      imageUrl: 'https://m.media-amazon.com/images/I/61dsEGE4t+L.jpg',
      description: 'Blue Dress',
      colors: ['Blue'],
      price: 60000,
      size: 'Size: S, M, L',
      stock: ['397']
    ),
    Product(
      id: '3',
      title: 'Casual Shirt',
      imageUrl: 'https://preloved.co.id/_ipx/f_webp,q_80,fit_cover,s_800x800/https://assets.preloved.co.id/products/32360/1f7012a7-949d-4236-b9ea-b1431cad8505.jpg',
      description: 'Comfortable Casual Shirt',
      colors: ['White', 'Black'],
      price: 40000,
      size: 'Size: S, M, L',
      stock: ['964']
    ),
    Product(
      id: '4',
      title: 'Sneakers Cool',
      imageUrl: 'https://i.ytimg.com/vi/W6vnF1M3ais/sd2.jpg?sqp=-oaymwEoCIAFEOAD8quKqQMcGADwAQH4Ab4EgALABIoCDAgAEAEYVCBVKGUwDw==&rs=AOn4CLCJAETT-mFIFcc2INFQE4Mob_VT5A',
      description: 'Stylish Sneakers',
      colors: ['Black', 'Red'],
      price: 30000,
      size: 'Size: 36, 37, 38, 39, 40, 41, 42',
      stock: ['947']
    ),
    Product(
      id: '5',
      title: 'Summer Hat',
      imageUrl: 'https://images.tokopedia.net/img/cache/500-square/VqbcmM/2021/3/21/cffa9ba9-c619-4adf-9e26-79da67e85464.jpg',
      description: 'Protective Summer Hat',
      colors: ['Yellow', 'Blue'],
      price: 20000,
      size: 'Size: One size',
      stock: ['3']
    ),
    Product(
      id: '6',
      title: 'Leather Wallet',
      imageUrl: 'https://elizabeth.co.id/wp-content/uploads/2024/03/0111-0009-01_0c.jpg',
      description: 'Stylish Leather Wallet',
      colors: ['Brown', 'Black'],
      price: 150000,
      size: 'Size: -',
      stock: ['397']
    ),
    Product(
      id: '7',
      title: 'Sports Watch',
      imageUrl: 'https://image.made-in-china.com/202f0j00SdNcwzLrSYoC/Sanda-6198-Sports-Luxury-50m-Waterproof-Wristwatch-Relogio-Masculino-Digital-Watch.jpg',
      description: 'Durable Sports Watch',
      colors: ['Black', 'Red'],
      price: 120000,
      size: 'Size: -',
      stock: ['257']
    ),
  ];
  final List<Product> recommendedProducts = [
    Product(
      id: '8',
      title: 'The Beater shirt',
      imageUrl: 'https://m.media-amazon.com/images/I/61omDZucWuL._AC_SX425_.jpg',
      description: 'The first rule of F**** C***',
      colors: ['Red'],
      price: 50000,
      size: 'Size: S, M, L',
      stock: ['36']
    ),
    Product(
      id: '9',
      title: 'Cool jacket',
      imageUrl: 'https://ae01.alicdn.com/kf/H19cfb2f11ffa4e13bd2bde675f3f4dbbV.jpg',
      description: 'Ora ora ora ora',
      colors: ['Black'],
      price: 250000,
      size: 'Size: S, M, L',
      stock: ['396']
    ),
    Product(
      id: '10',
      title: 'Weird cap',
      imageUrl: 'https://ae01.alicdn.com/kf/Sb2bec41c6da1425cadf7ffcc2b7e160cV.jpg_640x640q90.jpg',
      description: 'Do not try this',
      colors: ['Black'],
      price: 80000,
      size: 'Size: All size',
      stock: ['486']
    ),
    Product(
      id: '11',
      title: 'FlipFlopFlap',
      imageUrl: 'https://www.skechers.id/media/catalog/product/S/K/SKE220230BBK-3.jpg',
      description: 'Modern Flipflop',
      colors: ['Black', 'White'],
      price: 150000,
      size: 'Size: 36, 37, 38, 39, 40, 41, 42',
      stock: ['497']
    ),
  ];
  final List<Product> staffPicks = [
    Product(id: '12', title: 'Vintage Bag', imageUrl: 'https://tinkerlust.s3.ap-southeast-1.amazonaws.com/products/39f94c63-2087-40be-82a9-47b936e061f3/original/1280x1280/MP-25938-SB-1-Photoroom_MP-25938-SB-1.jpg', description: 'Classic Vintage Bag', colors: ['Brown'], price: 90000, size: 'Size: One size', stock: ['39']),
    Product(id: '13', title: 'Elegant Scarf', imageUrl: 'https://elizabetta.net/cdn/shop/files/ladies-black-silk-satin-foulard-made-in-Italy_2048x.jpg?v=1724250857', description: 'Silk Scarf', colors: ['Red'], price: 50000, size: 'Size: One size', stock: ['43']),
    Product(id: '14', title: 'Sunglasses', imageUrl: 'https://down-id.img.susercontent.com/file/id-11134207-7r98o-lkw42b9q571r86', description: 'Cool Shades', colors: ['Black'], price: 75000, size: 'Size: One size', stock: ['97']),
    Product(id: '15', title: 'Denim Jacket', imageUrl: 'https://images.tokopedia.net/img/cache/500-square/VqbcmM/2023/1/25/17e17810-6ebd-4f4d-b36c-7b389e5e3700.jpg', description: 'Stylish Denim Jacket', colors: ['Blue'], price: 200000, size: 'Size: S, M, L, XL, XXL', stock: ['3']),
  ];

  List<CartItem> cartItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Butik Krisna'),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {
            showSearch(context: context, delegate: CustomSearchDelegate(products: suggestedProducts));
          }),
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {
            Navigator.pushNamed(context, '/cart', arguments: cartItems);
          }),
          IconButton(icon: Icon(Icons.account_circle), onPressed: () {
            Navigator.pushNamed(context, '/profile', arguments: user);
          }),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionHeader('Suggested for You'),
            horizontalList(suggestedProducts),
            sectionHeader('Cool Thing'),
            horizontalList(recommendedProducts),
            sectionHeader('Staff Picks'),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.8,
              ),
              itemCount: staffPicks.length,
              itemBuilder: (context, index) {
                final item = staffPicks[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailPage(
                          product: item,
                          onAddToCart: (prod) => setState(() => cartItems.add(CartItem(product: prod))),
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                          child: Image.network(item.imageUrl, height: 100, width: double.infinity, fit: BoxFit.cover),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                              SizedBox(height: 4),
                              Text(
                                NumberFormat.currency(locale: 'id_ID', symbol: 'Rp').format(item.price),
                                style: TextStyle(fontSize: 12, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Spacer(),
          TextButton(onPressed: () {}, child: Text('View All', style: TextStyle(color: Colors.black))),
        ],
      ),
    );
  }

  Widget horizontalList(List<Product> list) {
    return Container(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (ctx, i) {
          final p = list[i];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ProductDetailPage(
                product: p,
                onAddToCart: (prod) => setState(() => cartItems.add(CartItem(product: prod))),
              )),
            ),
            child: Padding(
              padding: EdgeInsets.only(right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(p.imageUrl, height: 100, width: 100, fit: BoxFit.cover),
                  ),
                  SizedBox(height: 6),
                  Text(p.title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  Text(NumberFormat.currency(locale: 'id_ID', symbol: 'Rp').format(p.price), style: TextStyle(fontSize: 12, color: Colors.blueGrey)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}