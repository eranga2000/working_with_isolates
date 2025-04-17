import 'dart:isolate';

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
                ElevatedButton(
                  onPressed: () {
                    // Simulate a complex task
                    var total = complexTask1();
                    debugPrint("Total: $total");
                  },
                  child: Text("Task 1"),
                ),

                //Let's use isolates
                ElevatedButton(
                  onPressed: ()async {
                    // Simulate a complex task
                    final receivePort = ReceivePort();
                    await Isolate.spawn(complexTask2, receivePort.sendPort);
                    receivePort.listen((message) {
                      debugPrint("Total: $message");
                      receivePort.close();
                    });
                  },
                  child: Text("Task 2"),
                ),
                // ElevatedButton(onPressed: () {}, child: Text("Task 3")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double complexTask1() {
    var total = 0.0;
    for (int i = 0; i < 30000000; i++) {
      total += i;
    }
    return total;
  }
}

//declare the method out side of every classes

complexTask2(SendPort sendPort) {

  var total = 0.0;
  for (int i = 0; i <300000000; i++) {
    total += i;
  }
  sendPort.send(total);
}
