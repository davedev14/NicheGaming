// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:niche_gaming/ui/home_page.dart';

// import 'package:google_fonts/google_fonts.dart';


// import '../models/task.dart';
// import '../services/firestore_service.dart';
// import '../services/auth_service.dart';


// class CartPage extends StatelessWidget {
//   CartPage({super.key});

//   final FirestoreService service = FirestoreService();
//   final AuthService auth = AuthService();

//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//         if (user == null) {
//       return const Center(
//         child: Text("Usuário não encontrado"),
//       );
//     }
//     final userId = user.uid;
    

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(245, 245, 245, 245),

//       // APPBAR
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: Row(
//           children: [
//             Text(
//           'Carrinho',
//           style: GoogleFonts.passionOne(
//             color: const Color.fromARGB(255, 87, 205, 93),
//               fontSize: 34,
//               fontWeight: FontWeight.w700,
//               )
//             ),
//            ],
//           ),
          
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () async {

//               await auth.logout();
//               Navigator.pushAndRemoveUntil(

//                 context,

//                 MaterialPageRoute(builder: (_) => HomePage()),
//                 (route) => false,
//               );
//             },
//           ),
//         ],
//       ),

//       // BODY
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: StreamBuilder<List<Task>>(
//           stream: service.getTasks(userId),
//           builder: (_, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               if (snapshot.hasError) {
//                 return Center(
//                   child: Text(
//                     'Erro ao carregar dados:\n${snapshot.error}',
//                     textAlign: TextAlign.center,
//                   ),
//                 );
//               }

//               if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                 return const Center(child: Text('Nenhum item'));
//               }

//             final items = snapshot.data!;

//             if (items.isEmpty) {
//               return const Center(
//                 child: Text(
//                   'Carrinho vazio',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               );
//             }

//             return Column(
//               children: [
//                 // LISTA DE ITENS
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: items.length,
//                     itemBuilder: (_, index) {
//                       final item = items[index];

//                       return Container(
//                         margin: const EdgeInsets.only(bottom: 12),
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFECECEC),
//                           borderRadius: BorderRadius.circular(16),
//                         ),

//                         child: Row(
//                           children: [
//                             // IMAGEM
//                             buildProductImage(item.image),

//                             const SizedBox(width: 12),

//                             // INFO
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     item.title,
//                                     style: const TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),

//                                   const SizedBox(height: 4),

//                                   Text(
//                                     'R\$ ${item.price.toStringAsFixed(2)}',
//                                     style: const TextStyle(
//                                       color: Colors.green,
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),

//                           Row(
//                                 children: [
//                                   IconButton(
//                                     icon: const Icon(Icons.remove_circle_outline),
//                                     onPressed: () {
//                                       service.decreaseQuantity(item);
//                                     },
//                                   ),

//                                   Text(
//                                     item.quantity.toString(),
//                                     style: const TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),

//                                   IconButton(
//                                     icon: const Icon(Icons.add_circle_outline),
//                                     onPressed: () {
//                                       service.increaseQuantity(item);
//                                     },
//                                   ),
//                                 ],
//                               ),

//                             // REMOVER
//                             IconButton(
//                               icon: const Icon(
//                                 Icons.delete,
//                                 color: Colors.red,
//                               ),
//                               onPressed: () {
//                                 service.deleteTask(item.id!);
//                               },
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),

//                 // TOTAL
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         'Total',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         'R\$ ${_calculateTotal(items).toStringAsFixed(2)}',
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.green,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   double _calculateTotal(List<Task> items) {
//     double total = 0;
//     for (var item in items) {
//       total += item.price * item.quantity;
//     }
//     return total;
//   }
// }

// Widget buildProductImage(String? image) {
//   // PRODUTO SEM IMAGEM (cadastrado)
//   if (image == null || image.trim().isEmpty) {
//     return Container(
//       width: 60,
//       height: 60,
//       decoration: BoxDecoration(
//         color: Colors.grey[300],
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Icon(
//         Icons.shopping_bag,
//         size: 48,
//         color: Colors.grey,
//       ),
//     );
//   }

//   return ClipRRect(
//     borderRadius: BorderRadius.circular(8),
//     child: Image.network(
//       image,
//       width: 60,
//       height: 60,
//       fit: BoxFit.cover,
//       errorBuilder: (context, error, stackTrace) {
//         return Container(
//           width: 60,
//           height: 60,
//           color: Colors.grey[300],
//           child: const Icon(
//             Icons.broken_image,
//             size: 30,
//             color: Colors.grey,
//           ),
//         );
//       },
//     ),
//   );



//   // FALLBACK
//   // return const Icon(Icons.shopping_bag);
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:niche_gaming/ui/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/task.dart';
import '../services/firestore_service.dart';
import '../services/auth_service.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final FirestoreService service = FirestoreService();
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Center(
        child: Text("Usuário não encontrado"),
      );
    }
    final userId = user.uid;

    return Scaffold(
      backgroundColor: const Color.fromARGB(245, 245, 245, 245),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Text(
              'Carrinho',
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
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await auth.logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => HomePage()),
                (route) => false,
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
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Erro ao carregar dados:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Nenhum item'));
            }

            final items = snapshot.data!;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (_, index) {
                      final item = items[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12), // Ajuste leve de respiro interno
                        decoration: BoxDecoration(
                          color: const Color(0xFFECECEC),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            // IMAGEM COM TAMANHO FIXO E SEGURO
                            buildProductImage(item.image),

                            const SizedBox(width: 8),

                            // INFO: Envelopado em Expanded para limitar largura do título
                            Expanded(
                              flex: 3, // Dá prioridade de espaço proporcional ao texto
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    item.title,
                                    maxLines: 1, // Impede que o título estique a linha infinitamente
                                    overflow: TextOverflow.ellipsis, // Bota o "..." se o título for longo
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'R\$ ${item.price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // QUANTIDADE E CONTROLES (Protegido para não empurrar os cantos do Row)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: const Icon(Icons.remove_circle_outline, size: 22),
                                  onPressed: () => service.decreaseQuantity(item),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  child: Text(
                                    item.quantity.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: const Icon(Icons.add_circle_outline, size: 22),
                                  onPressed: () => service.increaseQuantity(item),
                                ),
                              ],
                            ),

                            // REMOVER
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 22,
                              ),
                              onPressed: () => service.deleteTask(item.id!),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // TOTAL
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'R\$ ${_calculateTotal(items).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  double _calculateTotal(List<Task> items) {
    double total = 0;
    for (var item in items) {
      total += item.price * item.quantity;
    }
    return total;
  }
}

Widget buildProductImage(String? image) {
  if (image == null || image.trim().isEmpty) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(
        Icons.shopping_bag,
        size: 32,
        color: Colors.grey,
      ),
    );
  }

  return ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: Image.network(
      image,
      width: 60,
      height: 60,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: 60,
          height: 60,
          color: Colors.grey[300],
          child: const Icon(
            Icons.broken_image,
            size: 30,
            color: Colors.grey,
          ),
        );
      },
    ),
  );
}