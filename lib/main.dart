import 'package:flutter/material.dart';
import 'services/theme_provider.dart';
import 'pages/login_page.dart';
import 'pages/cadastro_page.dart';
import 'pages/configuracoes_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeProvider.themeMode,
      builder: (_, mode, __) {
        return MaterialApp(
          title: 'App de Notas',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: mode,
          initialRoute: '/login',
          routes: {
            '/login': (context) => const LoginPage(),
            '/cadastro': (context) => const CadastroPage(),
            // ❌ NÃO DEFINA /home pois exige parâmetro!
            '/configuracoes': (context) => const ConfiguracoesPage(),
          },
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
