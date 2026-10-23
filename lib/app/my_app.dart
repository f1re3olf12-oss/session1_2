import 'package:flutter/material.dart';
import 'package:session1_2/features/home/ui/home_page/home_page.dart';

class MyApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}
