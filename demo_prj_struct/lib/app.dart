import 'package:demo_provider/ui/pages/home_page/home_page.dart';
import 'package:demo_provider/ui/pages/home_page/providers/home_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';





class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskProvider()),
        
      ],
      child: MaterialApp(
        title: 'Todo App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}