import 'package:flutter/material.dart';
import 'package:sidebar/sidebar/sidebarLayout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.white),
      home: Scaffold(
        body: SideBarLayout(),
      ),
    );
  }
}
