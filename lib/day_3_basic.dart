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
      home: const MyHomePage(title: 'I can layout this'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: FittedContainer(
                  right: true,
                  bottom: true,
                  child: Container(color: Colors.grey.shade400),
                ),
              ),
              Expanded(
                child: FittedContainer(
                  bottom: true,
                  child: FractionallySizedBox(
                    alignment: Alignment.topCenter,
                    heightFactor: 0.5,
                    child: Container(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: FittedContainer(
                  right: true,
                  child: FractionallySizedBox(
                    alignment: Alignment.bottomCenter,
                    heightFactor: 0.3,
                    child: Container(color: Colors.green),
                  ),
                ),
              ),
              Expanded(
                child: FittedContainer(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: FractionallySizedBox(
                      alignment: Alignment.topCenter,
                      heightFactor: 0.4,
                      child: Container(color: Colors.yellowAccent),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(color: Colors.yellow, width: 500, height: 100),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(color: Colors.brown, width: 500, height: 50),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FittedContainer extends StatelessWidget {
  const FittedContainer({
    super.key,
    this.left = false,
    this.right = false,
    this.top = false,
    this.bottom = false,
    required this.child,
  });
  final bool left;
  final bool right;
  final bool top;
  final bool bottom;
  final Widget child;

  final BorderSide myBorderSide = const BorderSide(
    color: Colors.black,
    width: 5,
  );

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: top ? myBorderSide : BorderSide.none,
            right: right ? myBorderSide : BorderSide.none,
            bottom: bottom ? myBorderSide : BorderSide.none,
            left: left ? myBorderSide : BorderSide.none,
          ),
        ),
        width: 250,
        height: 250,
        child: child,
      ),
    );
  }
}
