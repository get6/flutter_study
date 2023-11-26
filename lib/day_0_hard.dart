import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

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
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Flutter Demo'),
          ),
          body: const MyHomePage()),
    );
  }
}

enum ShapeType { circle, square }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _squreCounter = 0;
  int _circleCounter = 0;
  double _squreStrokeWidth = 2;
  double _circleStrokeWidth = 2;

  final _dragText = 'Drag Me!';

  @override
  Widget build(BuildContext context) {
    ShapeType shapeType =
        Random().nextInt(2) == 0 ? ShapeType.circle : ShapeType.square;
    Widget dragWidget = ShapeContainer(text: _dragText, shapeType: shapeType);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DragTarget(
                builder: (context, candidateData, rejectedData) {
                  return ShapeContainer(
                    text: _squreCounter.toString(),
                    width: 100,
                    height: 100,
                    strokeWidth: _squreStrokeWidth,
                    shapeType: ShapeType.square,
                  );
                },
                onWillAcceptWithDetails: (details) {
                  if (details.data == ShapeType.square) {
                    setState(() {
                      _squreStrokeWidth = 4;
                    });
                  }
                  return true;
                },
                onAccept: (data) {
                  if (data == ShapeType.square) {
                    setState(() {
                      _squreCounter++;
                      _squreStrokeWidth = 2;
                    });
                  }
                },
              ),
              const SizedBox(width: 200),
              DragTarget(
                builder: (context, candidateData, rejectedData) {
                  return ShapeContainer(
                    text: _circleCounter.toString(),
                    width: 100,
                    height: 100,
                    strokeWidth: _circleStrokeWidth,
                    shapeType: ShapeType.circle,
                  );
                },
                onWillAcceptWithDetails: (details) {
                  if (details.data == ShapeType.circle) {
                    setState(() {
                      _circleStrokeWidth = 4;
                    });
                  }
                  return true;
                },
                onAccept: (data) {
                  if (data == ShapeType.circle) {
                    setState(() {
                      _circleCounter++;
                      _circleStrokeWidth = 2;
                    });
                  }
                },
              ),
            ],
          ),
        ),
        Draggable(
          data: shapeType,
          feedback: dragWidget,
          childWhenDragging: const SizedBox(height: 80),
          child: dragWidget,
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class ShapeContainer extends StatelessWidget {
  const ShapeContainer({
    super.key,
    required this.text,
    this.width = 80,
    this.height = 80,
    this.strokeWidth = 2,
    required this.shapeType,
  });
  final double width;
  final double height;
  final String text;
  final double strokeWidth;
  final ShapeType shapeType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(8),
      decoration: shapeType == ShapeType.circle
          ? BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: strokeWidth),
            )
          : BoxDecoration(
              border: Border.all(width: strokeWidth),
              borderRadius: BorderRadius.circular(8),
            ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            decoration: TextDecoration.none,
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
