import 'package:flutter/material.dart';
import 'package:projeto_flutter/presentation/viewmodel/user_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  login() async {
    final viewModel = Provider.of<UserViewModel>(context, listen: false);
    final username = usernameController.text;
    final senha = senhaController.text;

    if (username.isEmpty || senha.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, preencha todos os campos.')),
        );
      }
      return;
    }

    try {
      bool sucesso = await viewModel.login(username, senha);
      if (mounted && sucesso) {
        Navigator.pushReplacementNamed(context, '/');
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Erro ao fazer login, verifique suas credenciais.'),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro ao fazer login: $e')));
      }
    }
  }

  void irParaRegistro() {
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 80.0),
              // Título
              const Text(
                'Bem-vindo de volta!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Faça login para continuar',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40.0),
              // Campo de usuário
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Usuário',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              // Campo de senha
              TextField(
                controller: senhaController,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24.0),
              // Botão de login
              ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Login', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 16.0),
              // Link para registro
              TextButton(
                onPressed: irParaRegistro,
                child: const Text(
                  'Não tem uma conta? Registre-se',
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
