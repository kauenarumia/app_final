import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/nota_model.dart';
import '../models/usuario_model.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:3000';

  // Notas
  static Future<List<Nota>> getNotas() async {
    final response = await http.get(Uri.parse('$baseUrl/notas'));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((json) => Nota.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar notas');
    }
  }

  static Future<Nota> addNota(Nota nota) async {
    final response = await http.post(
      Uri.parse('$baseUrl/notas'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(nota.toJson(includeId: false)),
    );
    if (response.statusCode == 201) {
      return Nota.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro ao adicionar nota');
    }
  }

  static Future<void> updateNota(Nota nota) async {
    final response = await http.put(
      Uri.parse('$baseUrl/notas/${nota.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(nota.toJson(includeId: true)),
    );
    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar nota');
    }
  }

  static Future<bool> deleteNota(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/notas/$id'));
    return response.statusCode == 200 || response.statusCode == 204;
  }

  // Usuário - login
  static Future<Usuario?> login(String email, String senha) async {
    final response = await http.get(
      Uri.parse('$baseUrl/usuarios?email=$email&senha=$senha'),
    );
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      if (body.isNotEmpty) {
        return Usuario.fromJson(body.first);
      } else {
        return null;
      }
    } else {
      throw Exception('Erro ao fazer login');
    }
  }

  // Usuário - cadastro
  static Future<bool> cadastrar(String nome, String email, String senha) async {
    final response = await http.post(
      Uri.parse('$baseUrl/usuarios'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'nome': nome, 'email': email, 'senha': senha}),
    );
    return response.statusCode == 201;
  }
}
