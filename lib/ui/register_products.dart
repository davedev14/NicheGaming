import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/products.dart';
import '../services/firestore_service.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();
  final priceController = TextEditingController();
  final imageController = TextEditingController();

  bool isLoading = false;

  Future<void> saveProduct() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    final userId = FirebaseAuth.instance.currentUser!.uid;

    final product = Products(
      title: titleController.text,
      description: descriptionController.text,
      category: categoryController.text,
      price: double.parse(priceController.text),
      imageUrl: imageController.text,
      sellerId: userId,
    );

    await FirestoreService().addTask(product);

    setState(() => isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Produto cadastrado com sucesso!')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECECEC),

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.green),
        title: Text(
          "Cadastrar Produto",
          style: GoogleFonts.passionOne(
            color: Colors.green,
            fontSize: 28,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              _buildField(titleController, "Título"),
              _buildField(descriptionController, "Descrição"),
              _buildField(categoryController, "Categoria"),

              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration("Preço"),
                validator: (value) =>
                    value!.isEmpty ? "Informe o preço" : null,
              ),

              _buildField(imageController, "URL da imagem"),

              const SizedBox(height: 20),

              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.all(14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: saveProduct,
                      child: const Text(
                        "Cadastrar Produto",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: _inputDecoration(label),
        validator: (value) =>
            value!.isEmpty ? "Campo obrigatório" : null,
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}