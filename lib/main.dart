
// Importa o Flutter (UI)
import 'package:flutter/material.dart';

// Importa o Firebase Core (obrigatório)
import 'package:firebase_core/firebase_core.dart';

// Configuração automática do Firebase
import 'firebase_options.dart';

// Tela inicial
import 'ui/login_page.dart';

void main() async {
  // Garante que o Flutter inicializou corretamente
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Firebase com as configurações geradas
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inicia o app
  runApp(MyApp());
}

// Classe principal do app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // remove banner debug
      home: LoginPage(), // primeira tela
    );
  }
}
