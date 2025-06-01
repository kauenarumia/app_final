import 'package:flutter/material.dart';
import '../models/usuario_model.dart';

class PerfilPage extends StatelessWidget {
  final Usuario usuario;

  const PerfilPage({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: ${usuario.nome}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text(
              'Email: ${usuario.email}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
