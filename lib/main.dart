import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:medai_try/contact_screen.dart';
import 'package:medai_try/home_screen.dart';
import 'package:medai_try/login_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Box box = await Hive.openBox('contactBox');
  box.put('name', {'seyam','123'});
  print(box.get('name'));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}


