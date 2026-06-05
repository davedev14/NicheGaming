import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:niche_gaming/ui/cart_page.dart';
import '../services/firestore_service.dart';

import '../data/home_products.dart';
import '../models/task.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  // final FirestoreService service = FirestoreService();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final user = FirebaseAuth.instance.currentUser!;
  // final userId = user.uid;
  String searchText = '';
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final List<Task> filteredProducts = homeProducts.where((product) {
        return product.title
            .toLowerCase()
            .contains(searchText.toLowerCase());
      }).toList();
    return Scaffold(
      backgroundColor: const Color(0xFFECECEC),

      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'image/logo.png',
              height: 24, // ajuste como quiser
            ),

            const SizedBox(width: 8),

            Text(
              'NicheGaming',
              style: GoogleFonts.passionOne(
                color: const Color.fromARGB(255, 87, 205, 93),
                fontSize: 34,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CartPage()
                ),
              );
            },
          ),
        ],

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.all(12),

            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchText = value.toLowerCase();
                });
              },
              style: TextStyle(color: Colors.black),

              decoration: InputDecoration(
                hintText: 'Buscar Produtos...',
                hintStyle: TextStyle(
                  color: const Color.fromARGB(179, 103, 103, 103),
                ),

                filled: true,

                fillColor: const Color(0xFFECECEC),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),


      body: Padding(
        padding: const EdgeInsets.all(16),

        child: GridView.builder(
          itemCount: filteredProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.70,
          ),
          itemBuilder: (context, index) {
            final Task product = filteredProducts[index];

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== IMAGEM + BOTÃO =====
                  Expanded(
                    child: Stack(
                      children: [
                        Center(
                          child: Image.asset(
                            product.image,
                            fit: BoxFit.contain,
                          ),
                        ),

                        // BOTÃO ADD CARRINHO
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),

                            child: IconButton(
                              icon: const Icon(Icons.shopping_cart, size: 20),
                              onPressed: () {
                                _addToCart(context, product);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ===== TEXTO =====
                  Padding(
                    padding: const EdgeInsets.all(10),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.category,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.green,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          'R\$ ${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ================= ADD AO CARRINHO =================
  void _addToCart(BuildContext context, Task product) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    final FirestoreService service = FirestoreService();

    service.addTask(
      Task(
        title: product.title,
        category: product.category,
        image: product.image,
        price: product.price,
        rating: product.rating,
        userId: userId,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Produto adicionado ao carrinho'),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
