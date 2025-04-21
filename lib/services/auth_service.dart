class AuthService {
  Map<String, String> _usuarios = {}; // Simula banco de dados

  bool verificarCadastro(String email) {
    return _usuarios.containsKey(email);
  }

  bool login(String email, String senha) {
    return _usuarios[email] == senha;
  }

  void registrar(String email, String senha) {
    _usuarios[email] = senha;
  }
}