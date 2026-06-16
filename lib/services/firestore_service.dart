import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task.dart';

class FirestoreService {

  final CollectionReference products =
      FirebaseFirestore.instance
          .collection('products');

  final CollectionReference tasks =
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
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    });
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
}