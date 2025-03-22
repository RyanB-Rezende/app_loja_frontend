import 'package:flutter/material.dart';
import 'package:projeto_flutter/data/repository/repository.dart';
import 'package:projeto_flutter/data/repository/user_repository.dart';
import 'package:projeto_flutter/presentation/pages/homepage.dart';
import 'package:projeto_flutter/presentation/pages/loginpage.dart';
import 'package:projeto_flutter/presentation/viewmodel/user_viewmodel.dart';
import 'package:projeto_flutter/presentation/viewmodel/viewmodel.dart';
import 'package:projeto_flutter/services/api_services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProdutoViewModel(ProdutoRepository(ApiServices())),
        ),
        ChangeNotifierProvider(
          create: (_) => UserViewModel(UserRepository(ApiServices())),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loja API',
      theme: ThemeData(primaryColor: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/': (context) => const Homepage(),
        '/login': (context) => const LoginPage(),
        // '/carrinho': (context) => const CarrinhoPage(),
      },
    );
  }
}
