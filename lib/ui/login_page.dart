import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

// Importa o serviço de autenticação
import '../services/auth_service.dart';

// Importa tela home
import 'home_page.dart';

// Importa tela cadastro
import 'register_page.dart';

class LoginPage extends StatelessWidget {

  // Controller do campo email
  final emailController =
      TextEditingController();

  // Controller da senha
  final passwordController =
      TextEditingController();

  // Instância do AuthService
  final auth = AuthService();

  // FUNÇÃO LOGIN
  void login(BuildContext context) async {

    // Executa login
    final error = await auth.login(
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

    // Navega para home
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      // Cor de fundo moderna
      backgroundColor: Color.fromARGB(245, 245, 245, 245),

      body: Center(

        child: SingleChildScrollView(

          child: Padding(

            padding: EdgeInsets.all(24),

            child: Column(

              children: [
                Transform.translate(
                offset: const Offset(0, -60),
                    child: SizedBox(
                      width: 320,
                      //  height: 320,
                      child: Image.asset('image/logo.png'),
                    ),
                  ), 

                SizedBox(height: 5),
              

                // Título
                Transform.translate(
                offset: const Offset(0, -20),
                  child: Text(
                    'NicheGaming',
                    style: GoogleFonts.passionOne(
                      color: const Color.fromARGB(255, 87, 205, 93),
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                SizedBox(height: 10),

                
               // Slogan
               Transform.translate(
               offset: const Offset(0, -20),
                  child: Text(
                    'Do hype ao classico, tudo em um',
                    style: GoogleFonts.passionOne(
                      color: const Color.fromARGB(179, 103, 103, 103),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
               ),

                SizedBox(height: 10),
              
              Transform.translate(
              offset: const Offset(0, -20),
                child: Text(
                  'só lugar',
                  style: GoogleFonts.passionOne(
                    color: const Color.fromARGB(179, 103, 103, 103),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

                SizedBox(height: 60),

                // CAMPO EMAIL
                TextField(

                  controller: emailController,

                  style: TextStyle(
                    color: Colors.white,
                  ),

                  decoration: InputDecoration(

                    labelText: 'E-mail',

                    labelStyle: TextStyle(
                      color: const Color.fromARGB(179, 103, 103, 103),
                    ),

                    filled: true,

                    fillColor: const Color(0xFFECECEC),

                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(12),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                // CAMPO SENHA
                TextField(

                  controller: passwordController,

                  obscureText: true,

                  style: TextStyle(
                    color: Colors.white,
                  ),

                  decoration: InputDecoration(

                    labelText: 'Senha',

                    labelStyle: TextStyle(
                      color: const Color.fromARGB(179, 103, 103, 103),
                    ),

                    filled: true,

                    fillColor: const Color(0xFFECECEC),

                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(12),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // BOTÃO LOGIN
                SizedBox(

                  width: double.infinity,

                  height: 55,

                  child: ElevatedButton(

                    onPressed: () => login(context),

                    style: ElevatedButton.styleFrom(

                      backgroundColor: const Color.fromARGB(255, 87, 205, 93),

                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(12),
                      ),
                    ),

                    child: Text(
                      'Entrar',
                      style: GoogleFonts.passionOne(
                        fontSize: 24,
                        color: Color.fromARGB(255, 255, 255, 255)
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                // BOTÃO CADASTRO
                SizedBox(
                  width: double.infinity,

                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              RegisterPage(),
                        ),
                      );
                    },

                      style: ElevatedButton.styleFrom(

                        backgroundColor: const Color.fromARGB(255, 87, 205, 93),

                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                      ),

                    child: Text(
                      'Criar conta',
                      style: GoogleFonts.passionOne(
                        fontSize: 24,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}