import 'package:flutter/material.dart';
import 'package:supabase_basics/controller/provider.dart';
import 'package:supabase_basics/pages/home_page.dart';
import 'package:supabase_basics/pages/sign_in_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://wycxlhxxcvnmvwcbtcao.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind5Y3hsaHh4Y3ZubXZ3Y2J0Y2FvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTUwMDA3NjEsImV4cCI6MjA3MDU3Njc2MX0.Tpp1r7l1bH2xBFvgkq-J6oVszCB3BchTZiG3950q9y8",
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StudentProvider(),
      child: MaterialApp(
        title: "Supabase Demo",
        home: Supabase.instance.client.auth.currentUser != null
            ? HomePage()
            : SignInPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
