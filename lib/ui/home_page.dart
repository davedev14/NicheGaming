import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:niche_gaming/ui/cart_page.dart';
// import 'package:niche_gaming/ui/login_page.dart';

import '../models/task.dart';
import '../services/firestore_service.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});

  final FirestoreService service = FirestoreService();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final userId = user.uid;

    return Scaffold(
      backgroundColor: const Color.fromARGB(245, 245, 245, 245),
      
      
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'image/logo.png',
                height: 28, // ajuste como quiser
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
                  MaterialPageRoute(
                    builder: (_) => CartPage(),
                  ),
                );
              },
            ),
          ],
        ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<List<Task>>(
          stream: service.getTasks(userId),
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final products = snapshot.data!;

            if (products.isEmpty) {
              return const Center(
                child: Text('Nenhum produto encontrado'),
              );
            }

            return GridView.builder(
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.70,
              ),
              itemBuilder: (_, index) {
                final product = products[index];

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // IMAGEM
                      Expanded(
                        child: Stack(
                          children: [
                            Center(
                              child: Image.network(
                                product.image,
                                fit: BoxFit.contain,
                              ),
                            ),

                            // BOTÃO CARRINHO
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.add_shopping_cart,
                                    size: 20,
                                  ),
                                  onPressed: () {
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
                                        content: Text(
                                          'Produto adicionado ao carrinho',
                                        ),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // TEXTO
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
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
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
            );
          },
        ),
      ),
    );
  }
}
