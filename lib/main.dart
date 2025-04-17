import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/loading.gif'),
                //UI blocking task
                ElevatedButton(onPressed: () {
                  // Simulate a complex task
                 var total= complexTask1();
                 debugPrint("Total: $total");
                }, child: Text("Task 1")),

//Let's use isolates

                ElevatedButton(onPressed: () {}, child: Text("Task 2")),
                ElevatedButton(onPressed: () {}, child: Text("Task 3")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double complexTask1() {
    var total = 0.0;
    for (int i = 0; i < 1000000; i++) {
      total += i;
    }
    return total;
  }
}
