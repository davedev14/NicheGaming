import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/auth_service.dart';

class RegisterPage extends StatelessWidget {

  // Controller email
  final emailController =
      TextEditingController();

  // Controller senha
  final passwordController =
      TextEditingController();

  // Serviço autenticação
  final auth = AuthService();

  // FUNÇÃO CADASTRO
  void register(BuildContext context) async {

    final error = await auth.register(

      emailController.text,

      passwordController.text,
    );

    // Verifica erro
    if (error != null) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(error),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    // Mensagem sucesso
    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(
        content:
        Text('Cadastro realizado!'),
        backgroundColor: Colors.green,
      ),
    );

    // Volta para login
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Color.fromARGB(245, 245, 245, 245),

      // appBar: AppBar(

      //   backgroundColor: Colors.transparent,

      //   elevation: 0,

      //   title: Text('Cadastrar-se'),
      // ),

      body: Padding(

        padding: EdgeInsets.all(24),

        child: Column(

          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            // EMAIL
            TextField(

              controller: emailController,

              style: TextStyle(
                color: Colors.black,
              ),

              decoration: InputDecoration(

                labelText: 'E-mail',

                filled: true,

                fillColor: Color(0xFFECECEC),

                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 20),

            // SENHA
            TextField(

              controller: passwordController,

              obscureText: true,

              style: TextStyle(
                color: Colors.white,
              ),

              decoration: InputDecoration(

                labelText: 'Senha',

                filled: true,

                fillColor: Color(0xFFECECEC),

                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 30),

            // BOTÃO CADASTRAR
            SizedBox(

              width: double.infinity,

              height: 55,

              child: ElevatedButton(

                onPressed: () =>
                    register(context),

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 87, 205, 93),

                  shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                ),
                
                              
                child: Text(
                  'Cadastrar-se',
                  style: GoogleFonts.passionOne(
                    fontSize: 28,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}