class Nota {
  final String? id;
  final String titulo;
  final String conteudo;

  Nota({this.id, required this.titulo, required this.conteudo});

  factory Nota.fromJson(Map<String, dynamic> json) {
    int? id;
    if (json['id'] is int) {
      id = json['id'] as int;
    } else if (json['id'] is String) {
      id = int.tryParse(json['id']);
    } else {
      id = null;
    }

    return Nota(
      id: id.toString(),
      titulo: (json['titulo'] ?? '') as String,
      conteudo: (json['conteudo'] ?? '') as String,
    );
  }

  Map<String, dynamic> toJson({bool includeId = false}) {
    final data = {'titulo': titulo, 'conteudo': conteudo};
    if (includeId && id != null) {
      data['id'] = id.toString();
    }
    return data;
  }
}
