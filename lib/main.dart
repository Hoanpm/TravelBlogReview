import 'package:flutter/material.dart';
import 'package:travelblog/features/auth/view/getting_start_view.dart';
import 'package:travelblog/features/auth/view/login_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://tdumevsitntjlnxqowlz.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRkdW1ldnNpdG50amxueHFvd2x6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM5NzU0MjcsImV4cCI6MjAyOTU1MTQyN30.wtQni3MsHu4UJnMijYeiosbqFNGz5PD9I0cYL9TE6zY',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StartView(),
    );
  }
}

