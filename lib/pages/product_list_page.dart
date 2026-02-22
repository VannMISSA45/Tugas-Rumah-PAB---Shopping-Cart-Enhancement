import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../models/cart_model.dart';
import 'cart_page.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  String formatHarga(int harga) {
    return harga.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Product> products = [
      Product(
        id: 'm1',
        name: 'Mobil Remote Control',
        price: 250000,
        emoji: '🏎️',
        description: 'Mobil balap cepat.',
      ),
      Product(
        id: 'm2',
        name: 'Boneka Beruang Jumbo',
        price: 150000,
        emoji: '🧸',
        description: 'Lembut dan empuk.',
      ),
      Product(
        id: 'm3',
        name: 'Set Balok Susun',
        price: 350000,
        emoji: '🧱',
        description: 'Melatih kreativitas.',
      ),
      Product(
        id: 'm4',
        name: 'Robot Pintar AI',
        price: 450000,
        emoji: '🤖',
        description: 'Robot bisa bicara dan menari.',
      ),
      Product(
        id: 'm5',
        name: 'Puzzle Peta Dunia',
        price: 120000,
        emoji: '🧩',
        description: 'Belajar geografi jadi seru.',
      ),
      Product(
        id: 'm6',
        name: 'Mainan Masak-masakan',
        price: 180000,
        emoji: '🍳',
        description: 'Set lengkap untuk koki cilik.',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'JAJAN MAINAN',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
            fontSize: 40,
          ),
        ),
        centerTitle: true,
        actions: [
          Consumer<CartModel>(
            builder: (context, cart, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CartPage()),
                    ),
                  ),
                  if (cart.itemCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${cart.itemCount}',
                          style: const TextStyle(
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
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          childAspectRatio: 0.7,
          crossAxisSpacing: 6,
          mainAxisSpacing: 6,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              color: const Color(0xFF1E1E26),
              child: InkWell(
                onTap: () {
                  context.read<CartModel>().addItem(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.name} +1'),
                      duration: const Duration(milliseconds: 500),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        width: double.infinity,
                        color: const Color(0xFF2D2D3A),
                        child: Center(
                          child: Text(
                            product.emoji,
                            style: const TextStyle(fontSize: 80),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Rp${product.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 184, 184, 190),
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
