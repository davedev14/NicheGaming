import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/task.dart';

import '../services/firestore_service.dart';

import '../services/auth_service.dart';

import 'login_page.dart';

class HomePage extends StatelessWidget {

  // Controller input
  final controller =
      TextEditingController();

  // Serviço Firestore
  final service =
      FirestoreService();

  // Serviço Auth
  final auth =
      AuthService();

  // ADICIONAR TAREFA
  void addTask(String userId) {

    // Valida vazio
    if (controller.text.isEmpty) {
      return;
    }

    // Cria tarefa
    service.addTask(

      Task(
        title: controller.text,
        userId: userId,
      ),
    );

    // Limpa campo
    controller.clear();
  }

  // EDITAR TAREFA
  void editTask(
      BuildContext context,
      Task task,
      ) {

    final editController =
    TextEditingController(
      text: task.title,
    );

    showDialog(

      context: context,

      builder: (_) {

        return AlertDialog(

          title:
          Text('Editar tarefa'),

          content: TextField(
            controller: editController,
          ),

          actions: [

            TextButton(

              onPressed: () {

                Navigator.pop(context);
              },

              child: Text('Cancelar'),
            ),

            ElevatedButton(

              onPressed: () {

                // Atualiza título
                task.title =
                    editController.text;

                // Atualiza banco
                service.updateTask(task);

                Navigator.pop(context);
              },

              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    // Usuário logado
    final user =
        FirebaseAuth.instance.currentUser!;

    final userId = user.uid;

    return Scaffold(

      backgroundColor:
      Color.fromARGB(245, 245, 245, 245),

      // APPBAR
      appBar: AppBar(

        backgroundColor:
        Colors.transparent,

        elevation: 0,

        title:
        Text('Minhas tarefas'),

        actions: [

          // BOTÃO SAIR
          IconButton(

            icon: Icon(Icons.logout),

            onPressed: () async {

              // Logout
              await auth.logout();

              // Vai login
              Navigator.pushAndRemoveUntil(

                context,

                MaterialPageRoute(
                  builder: (_) =>
                      LoginPage(),
                ),

                    (route) => false,
              );
            },
          ),
        ],
      ),

      body: Padding(

        padding: EdgeInsets.all(16),

        child: Column(

          children: [

            // INPUT
            Container(

              padding:
              EdgeInsets.symmetric(
                horizontal: 12,
              ),

              decoration: BoxDecoration(

                color:
                Color(0xFF1E293B),

                borderRadius:
                BorderRadius.circular(12),
              ),

              child: Row(

                children: [

                  Expanded(

                    child: TextField(

                      controller: controller,

                      style: TextStyle(
                        color: Colors.white,
                      ),

                      decoration:
                      InputDecoration(

                        hintText:
                        'Nova tarefa',

                        border:
                        InputBorder.none,
                      ),
                    ),
                  ),

                  // BOTÃO ADD
                  IconButton(

                    icon: Icon(
                      Icons.add,
                      color: Colors.orange,
                    ),

                    onPressed: () =>
                        addTask(userId),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // LISTA
            Expanded(

              child:
              StreamBuilder<List<Task>>(

                stream:
                service.getTasks(userId),

                builder: (_, snapshot) {

                  // Loading
                  if (!snapshot.hasData) {

                    return Center(
                      child:
                      CircularProgressIndicator(),
                    );
                  }

                  final tasks =
                  snapshot.data!;

                  // Sem tarefas
                  if (tasks.isEmpty) {

                    return Center(

                      child: Text(

                        'Nenhuma tarefa',

                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                    );
                  }

                  // LISTVIEW
                  return ListView.builder(

                    itemCount: tasks.length,

                    itemBuilder: (_, index) {

                      final task =
                      tasks[index];

                      return Container(

                        margin:
                        EdgeInsets.only(
                          bottom: 12,
                        ),

                        padding:
                        EdgeInsets.all(16),

                        decoration:
                        BoxDecoration(

                          color:
                          Color(0xFF1E293B),

                          borderRadius:
                          BorderRadius.circular(16),
                        ),

                        child: Row(

                          children: [

                            // CHECKBOX
                            Checkbox(

                              value: task.done,

                              activeColor:
                              Colors.orange,

                              onChanged: (_) {

                                task.done =
                                !task.done;

                                service
                                    .updateTask(task);
                              },
                            ),

                            // TEXTO
                            Expanded(

                              child: Text(

                                task.title,

                                style: TextStyle(

                                  color:
                                  Colors.white,

                                  fontSize: 16,

                                  decoration:
                                  task.done

                                      ? TextDecoration
                                      .lineThrough

                                      : null,
                                ),
                              ),
                            ),

                            // EDITAR
                            IconButton(

                              icon: Icon(
                                Icons.edit,
                                color:
                                Colors.amber,
                              ),

                              onPressed: () {

                                editTask(
                                  context,
                                  task,
                                );
                              },
                            ),

                            // EXCLUIR
                            IconButton(

                              icon: Icon(
                                Icons.delete,
                                color:
                                Colors.red,
                              ),

                              onPressed: () {

                                service
                                    .deleteTask(
                                  task.id!,
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}