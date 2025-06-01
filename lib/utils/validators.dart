class Validators {
  static String? validarEmail(String? value) {
    if (value == null || value.isEmpty) return 'E-mail obrigatório';
    final emailRegex = RegExp(r'^.+@.+\..+$');
    if (!emailRegex.hasMatch(value)) return 'E-mail inválido';
    return null;
  }

  static String? validarSenha(String? value) {
    if (value == null || value.length < 6) return 'Mínimo 6 caracteres';
    return null;
  }

  static String? confirmarSenha(String? senha, String? confirmacao) {
    if (senha != confirmacao) return 'As senhas não coincidem';
    return null;
  }
}
