import 'package:flutter/material.dart';
import 'package:project_3/pages/information.dart';
// import 'package:project_3/pages/information.dart';
import 'package:project_3/pages/map.dart';

void main() {
  runApp(MyWidget());
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return MyApp();
  }
}

// import 'package:flutter/material.dart';
// import 'package:project_3/pages/map.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Map App',
//       theme: ThemeData(
//         primarySwatch: Colors.teal,
//       ),
//       home: MyApp(),
//       // home: StyledMapWidget(), // Используем StyledMapWidget как главный экран
//     );
//   }
// }
