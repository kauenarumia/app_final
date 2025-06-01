import 'package:flutter/material.dart';
import '../services/theme_provider.dart';

class ConfiguracoesPage extends StatelessWidget {
  const ConfiguracoesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Tema Escuro'),
            trailing: ValueListenableBuilder<ThemeMode>(
              valueListenable: ThemeProvider.themeMode,
              builder: (_, mode, __) {
                return Switch(
                  value: mode == ThemeMode.dark,
                  onChanged: (val) {
                    ThemeProvider.toggleTheme();
                  },
                );
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notificações'),
            trailing: Switch(
              value: true,
              onChanged: (val) {
                // Lógica para notificações futuramente
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Sobre o App'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'App de Notas',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2025 Seu Nome',
              );
            },
          ),
        ],
      ),
    );
  }
}
