import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:insightmind_app/features/insightmind/data/local/user.dart';
import 'package:insightmind_app/features/insightmind/presentation/screen/navigation_screen.dart';
import 'package:insightmind_app/features/insightmind/presentation/screen/register_screen.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/button_action.dart';
import 'package:insightmind_app/features/insightmind/presentation/widget/scaffold_app.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    debugPrint("Login button pressed");
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    debugPrint("Email: $email");

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email dan kata sandi harus diisi")),
      );
      return;
    }

    debugPrint("Checking if box is open...");
    final usersBox = Hive.box<User>('users');
    debugPrint("Box is open. Searching user...");
    final user = usersBox.values.firstWhere(
      (u) => u.email == email && u.password == password,
      orElse: () =>
          User(name: '', email: '', password: ''), // Dummy user if not found
    );
    debugPrint("User found status: ${user.email.isNotEmpty}");

    if (user.email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email atau kata sandi salah")),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const NavigationScreen()),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return ScaffoldApp(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Text(
                "Masuk",
                style: textStyle.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "Selamat datang kembali di InsightMind",
                style: textStyle.bodyLarge?.copyWith(
                  color: color.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, constraints) {
                  final screenWidth = MediaQuery.of(context).size.width;
                  final logoSize = screenWidth > 600 ? 200.0 : 140.0;
                  return Center(
                    child: Image.asset(
                      'assets/image/logo.png',
                      height: logoSize,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: logoSize,
                          width: logoSize,
                          decoration: BoxDecoration(
                            color: color.primaryContainer,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.psychology,
                            size: logoSize * 0.5,
                            color: color.primary,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Kata Sandi",
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  ButtonAction(
                    color: color,
                    textStyle: textStyle,
                    titleAction: "Masuk",
                    onPressed: _login,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Belum punya akun? ", style: textStyle.bodyMedium),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Daftar",
                      style: textStyle.bodyMedium?.copyWith(
                        color: color.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
