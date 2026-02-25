// lib/pages/product_list_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/product.dart';
import '../model/cart_model.dart';
import 'cart_page.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy products (Album TASTE Versions)
    final products = [
      AlbumTaste(
        id: '1',
        name: 'TASTE - Savory Ver.',
        price: 350000,
        image: 'savory.jpg',
        description: 'CD-R, photobook, postcards, secret message card.',
      ),
      AlbumTaste(
        id: '2',
        name: 'TASTE - Full Spread Ver.',
        price: 420000,
        image: 'fullspread.jpg',
        description: '96p photobook, poster, sticker, photocard.',
      ),
      AlbumTaste(
        id: '3',
        name: 'TASTE - Tin Case Ver.',
        price: 500000,
        image: 'tincase.jpg',
        description: 'Tin case, mini CD, accordion photos, pin.',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Album Taste'),
        actions: [
          Consumer<CartModel>(
            builder: (context, cart, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(),
                        ),
                      );
                    },
                  ),
                  if (cart.itemCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Text(
                          '${cart.itemCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),

      // ✅ RESPONSIVE GRID
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Hitung jumlah kolom berdasarkan lebar layar
          int crossAxisCount = (constraints.maxWidth / 250).floor();
          if (crossAxisCount < 1) crossAxisCount = 1;

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return _buildProductCard(context, product);
            },
          );
        },
      ),
    );
  }

  // ✅ PRODUCT CARD RESPONSIVE
  Widget _buildProductCard(BuildContext context, AlbumTaste product) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          // 🔥 IMAGE AREA (Flexible, tidak pakai height fix lagi)
          Expanded(
            flex: 4,
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/${product.image}',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // 🔥 DETAIL AREA
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Rp ${product.price.toStringAsFixed(0)}',
                        style: TextStyle(
                          color: Colors.green[700],
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),

                  // 🔥 BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.read<CartModel>().addItem(product);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${product.name} ditambahkan ke cart!',
                            ),
                            duration: const Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(Icons.add_shopping_cart, size: 16),
                      label: const Text('Add', style: TextStyle(fontSize: 12)),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
