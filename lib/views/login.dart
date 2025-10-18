import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  Future<void> login() async {
    final response = await Supabase.instance.client.auth.signInWithPassword(
      email: emailController.text,
      password: senhaController.text,
    );

    if (response.user != null) {
      Navigator.pushNamed(context, '/lista');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('E-mail ou senha incorretos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                  labelText: "E-mail", border: OutlineInputBorder()),
            ),
            TextField(
              controller: senhaController,
              obscureText: true,
              decoration: const InputDecoration(
                  labelText: "Senha", border: OutlineInputBorder()),
            ),
            ElevatedButton(
              onPressed: login,
              child: const Text("Login"),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/registro'),
              child: const Text("Registre-se"),
            ),
          ],
        ),
      ),
    );
  }
}
