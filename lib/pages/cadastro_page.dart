// pages/cadastro_page.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/validators.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();
  bool _loading = false;

  Future<void> _cadastrar() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _loading = true);
      bool sucesso = await ApiService.cadastrar(
        _nomeController.text,
        _emailController.text,
        _senhaController.text,
      );
      setState(() => _loading = false);

      if (sucesso) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cadastro realizado com sucesso')),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Erro ao cadastrar')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Nome obrigatório' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'E-mail'),
                validator: Validators.validarEmail,
              ),
              TextFormField(
                controller: _senhaController,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: Validators.validarSenha,
              ),
              TextFormField(
                controller: _confirmarSenhaController,
                decoration: const InputDecoration(labelText: 'Confirmar Senha'),
                obscureText: true,
                validator: (value) =>
                    Validators.confirmarSenha(_senhaController.text, value),
              ),
              const SizedBox(height: 20),
              _loading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _cadastrar,
                      child: const Text('Cadastrar'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
