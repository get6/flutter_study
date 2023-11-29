import 'dart:async';

import 'package:flutter/material.dart';

// void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    super.key,
    required this.title,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int score = 0;
  double value = 0.0;

  void _incrementValue() {
    setState(() {
      value += 0.3;
      if (0.9 <= value) {
        score++;
      }
    });
    if (0.0 < value) {
      Timer.periodic(const Duration(milliseconds: 400), (timer) {
        setState(() {
          value -= 0.1;
          if (value <= 0.0) {
            timer.cancel();
            score = 0;
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            const Text(
              'Your score',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Text(
              score.toString(),
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 320,
            child: RotatedBox(
              quarterTurns: -1,
              child: LinearProgressIndicator(
                backgroundColor: Colors.black,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                minHeight: 40,
                value: value,
              ),
            ),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () => _incrementValue(),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
