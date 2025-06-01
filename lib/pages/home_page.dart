import 'package:flutter/material.dart';
import '../models/nota_model.dart';
import '../models/usuario_model.dart';
import '../services/api_service.dart';
import 'package:app_final/pages/perfil_page.dart';
import 'login_page.dart';
import 'configuracoes_page.dart';

class HomePage extends StatefulWidget {
  final Usuario usuario;

  const HomePage({super.key, required this.usuario});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Nota>> _notasFuture;

  @override
  void initState() {
    super.initState();
    _carregarNotas();
  }

  void _carregarNotas() {
    _notasFuture = ApiService.getNotas();
  }

  void _exibirFormulario({Nota? nota}) async {
    final tituloController = TextEditingController(text: nota?.titulo);
    final conteudoController = TextEditingController(text: nota?.conteudo);

    final resultado = await showDialog<Nota>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(nota == null ? 'Nova Nota' : 'Editar Nota'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: tituloController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: conteudoController,
              decoration: const InputDecoration(labelText: 'Conteúdo'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final novaNota = Nota(
                id: nota?.id,
                titulo: tituloController.text,
                conteudo: conteudoController.text,
              );
              Navigator.pop(context, novaNota);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );

    if (resultado != null) {
      if (nota == null) {
        await ApiService.addNota(resultado);
      } else {
        await ApiService.updateNota(resultado);
      }
      setState(() => _carregarNotas());
    }
  }

  void _excluirNota(String id) async {
    await ApiService.deleteNota(id);
    setState(() => _carregarNotas());
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minhas Notas')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Olá, ${widget.usuario.nome}',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.note),
              title: const Text('Notas'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PerfilPage(usuario: widget.usuario),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ConfiguracoesPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sair'),
              onTap: _logout,
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Nota>>(
        future: _notasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar notas: ${snapshot.error}'),
            );
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma nota encontrada'));
          }

          final notas = snapshot.data!;
          return ListView.builder(
            itemCount: notas.length,
            itemBuilder: (context, index) {
              final nota = notas[index];
              return ListTile(
                title: Text(nota.titulo),
                subtitle: Text(nota.conteudo),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _exibirFormulario(nota: nota),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        if (nota.id != null) {
                          _excluirNota(nota.id!);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Erro: nota sem ID não pode ser excluída',
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _exibirFormulario(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
