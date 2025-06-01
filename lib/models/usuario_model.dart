class Usuario {
  final int? id;
  final String nome;
  final String email;
  final String senha;

  Usuario({
    this.id,
    required this.nome,
    required this.email,
    required this.senha,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    int? id;
    if (json['id'] is int) {
      id = json['id'] as int;
    } else if (json['id'] is String) {
      id = int.tryParse(json['id']);
    }

    return Usuario(
      id: id,
      nome: (json['nome'] ?? '') as String,
      email: (json['email'] ?? '') as String,
      senha: (json['senha'] ?? '') as String,
    );
  }

  Map<String, dynamic> toJson({bool includeId = false}) {
    final data = {'nome': nome, 'email': email, 'senha': senha};
    if (includeId && id != null) {
      data['id'] = id.toString();
      ;
    }
    return data;
  }
}
