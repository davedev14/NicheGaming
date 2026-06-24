import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:niche_gaming/models/products.dart';

import '../models/task.dart';

class FirestoreService {

  final CollectionReference products =
      FirebaseFirestore.instance
          .collection('products');

  final CollectionReference<Map<String, dynamic>> tasks =
    FirebaseFirestore.instance
        .collection('tasks');

  // LISTAR
  Future<List<Task>> getProducts() async {
    final snapshot = await products.get();


      return snapshot.docs.map((doc) {
        return Task.fromMap(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );

      }).toList();
  }

  Stream<List<Task>> getTasks(String userId) {
    return tasks
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Task.fromMap(
          doc.data(),
          doc.id,
        );
      }).toList();
    });
  }

  Future<void> addProduct(Products product) async {
  await FirebaseFirestore.instance
      .collection('products')
      .add(product.toMap());
}
  // ADICIONAR
  Future<void> addTask(Task task) async {

    await tasks.add(task.toMap());
  }

  // ATUALIZAR
  Future<void> updateTask(Task task) async {

    await tasks.doc(task.id)
        .update(task.toMap());
  }

  // EXCLUIR
  Future<void> deleteTask(
      String id,
      ) async {

    await tasks.doc(id).delete();
  }

  Future<void> increaseQuantity(Task task) async {
  await tasks.doc(task.id).update({
    'quantity': task.quantity + 1,
  });
}

Future<void> decreaseQuantity(Task task) async {
  if (task.quantity > 1) {
    await tasks.doc(task.id).update({
      'quantity': task.quantity - 1,
    });
  } else {
    await tasks.doc(task.id).delete(); // remove se chegar a 0
  }
  }

  Future<void> deleteProduct(String productId) async {
  await FirebaseFirestore.instance
      .collection('products')
      .doc(productId)
      .delete();
  }

Future<void> updateProduct(String productId, Products product) async {
    try {
      // Alterado de _productsCollection.doc para products.doc
      await products.doc(productId).update(product.toMap());
    } catch (e) {
      print("Erro ao atualizar produto: $e");
      rethrow;
    }
  }

}








// Future<void> deleteProduct(String productId) async {
//   await FirebaseFirestore.instance
//       .collection('products')
//       .doc(productId)
//       .delete();
// }

// Future<void> increaseQuantity(Task task) async {
//   await tasks.doc(task.id).update({
//     'quantity': task.quantity + 1,
//   });
// }

// Future<void> decreaseQuantity(Task task) async {
//   if (task.quantity > 1) {
//     await tasks.doc(task.id).update({
//       'quantity': task.quantity - 1,
//     });
//   } else {
//     await tasks.doc(task.id).delete(); // remove se chegar a 0
//   }
// }