import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

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
    Widget dragWidget = shapeType == ShapeType.circle
        ? CircleContainer(text: _dragText)
        : SqureContainer(text: _dragText);

    return DraggableContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DragTarget(
                  builder: (context, candidateData, rejectedData) {
                    return SqureContainer(
                      text: _squreCounter.toString(),
                      width: 100,
                      height: 100,
                      strokeWidth: _squreStrokeWidth,
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
                    return CircleContainer(
                      text: _circleCounter.toString(),
                      width: 100,
                      height: 100,
                      strokeWidth: _circleStrokeWidth,
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
      ),
    );
  }
}

class CircleContainer extends StatelessWidget {
  const CircleContainer({
    super.key,
    required this.text,
    this.width = 80,
    this.height = 80,
    this.strokeWidth = 2,
  });
  final double width;
  final double height;
  final String text;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: strokeWidth),
      ),
      child: Center(child: Text(text)),
    );
  }
}

class SqureContainer extends StatelessWidget {
  const SqureContainer({
    super.key,
    required this.text,
    this.width = 80,
    this.height = 80,
    this.strokeWidth = 2,
  });
  final double width;
  final double height;
  final String text;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(width: strokeWidth),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(child: Text(text)),
    );
  }
}

class DraggableContainer extends StatefulWidget {
  const DraggableContainer({super.key, required this.child});
  final Widget child;

  @override
  State<DraggableContainer> createState() => _DraggableContainerState();
}

class _DraggableContainerState extends State<DraggableContainer>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Alignment _dragAlignment = Alignment.center;
  Animation<Alignment>? _animation;

  void _runAnimation(Offset pixelsPerSecond, Size size) {
    _animation = _controller?.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment.center,
      ),
    );
    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    _controller!.animateWith(simulation);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _controller?.addListener(() {
      setState(() {
        _dragAlignment = _animation!.value;
      });
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onPanDown: (details) {
        _controller?.stop();
      },
      onPanUpdate: (details) {
        setState(() {
          _dragAlignment += Alignment(
            details.delta.dx / (size.width / 2),
            details.delta.dy / (size.height / 2),
          );
        });
      },
      onPanEnd: (details) {
        _runAnimation(details.velocity.pixelsPerSecond, size);
      },
      child: Align(
        alignment: _dragAlignment,
        child: widget.child,
      ),
    );
  }
}
